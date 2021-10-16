import typing as t
from pathlib import Path
import json

from entrez_tools.common import lookslike_uid
from entrez_tools.db import get_db, DbArg


class BasicEsummaryStoreBase(t.MutableMapping[str, dict]):

	def __init__(self, dir):
		self.dir = Path(dir)

	def _is_valid_key(self, key: str):
		raise NotImplementedError()

	def _file(self, key):
		return self.dir / (key + '.json')

	def __len__(self):
		return sum(1 for key in self)

	def __iter__(self):
		for file in self.dir.glob('*.json'):
			if self._is_valid_key(file.stem):
				yield file.stem

	def __contains__(self, key):
		return self._is_valid_key(key) and self._file(key).is_file()

	def __getitem__(self, key):
		if key not in self:
			raise KeyError(key)
		with self._file(key).open() as f:
			return json.load(f)

	def __setitem__(self, key, value):
		raise RuntimeError('Use add() method instead')


class BasicEsummaryStore(BasicEsummaryStoreBase):
	"""Stores ESummary JSON files in a directory.

	Acts as a mutable mapping from UIDs
	"""

	def __init__(self, db: DbArg, dir):
		BasicEsummaryStoreBase.__init__(self, dir)
		self.db = get_db(db)
		self.by_acc = BasicEsummaryStore.ByAccession(self)

	def _is_valid_key(self, key: str) -> bool:
		return lookslike_uid(key)

	def __delitem__(self, uid):
		if uid not in self:
			raise KeyError(uid)

		file = self._file(uid)
		file.unlink()

		# Delete accession file
		for file2 in self.dir.iterdir():
			if file2.is_symlink() and file2.readlink() == file:
				file2.unlink()

	def add(self, summary: dict):
		uid = summary['uid']
		assert lookslike_uid(uid)
		acc = summary[self.db.accession_esummary_attr]
		assert not lookslike_uid(acc)

		with open(self._file(uid), 'w') as f:
			json.dump(summary, f)

		self._file(acc).symlink_to(self._file(uid).name)

	def acc_to_uid(self, acc: str) -> t.Optional[str]:
		f = self._file(acc)
		if self.by_acc._is_valid_key(acc) and f.is_file():
			return f.readlink().stem
		return None

	def check(self):
		pass

	class ByAccession(BasicEsummaryStoreBase):

		def __init__(self, by_uid):
			BasicEsummaryStoreBase.__init__(self, by_uid.dir)
			self.by_uid = by_uid

		def _is_valid_key(self, key):
			return not lookslike_uid(key)

		def __delitem__(self, acc):
			if acc not in self:
				raise KeyError(acc)

			acc_file = self._file(acc)
			assert acc_file.is_symlink()
			assert not acc_file.readlink().is_absolute()
			uid_file = self.dir / acc_file.readlink()

			acc_file.unlink()
			if uid_file.is_file():
				uid_file.unlink()

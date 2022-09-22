from pathlib import Path
from subprocess import run


class BenchmarkBase:
	
	def __init__(self, work_dir: Path, prep_dir: Path, query_genomes, ref_genomes, params, opts):
		self.work_dir = work_dir
		self.prep_dir = prep_dir
		self.query_genomes = query_genomes
		self.ref_genomes = ref_genomes
		self.params = params
		self.opts = opts
		
		self._post_init()
		
	def _post_init(self):
		pass
		
	def prepare(self):
		pass

	def run(self):
		pass

	def check(self):
		pass


def make_list_file(files, out):
	with open(out, 'w') as fp:
		for f in files:
			fp.write(f'{f}\n')


def mash_sketch(cmd, list_file, out, s, k, nthreads=None):
	cmd = list(map(str, [
		cmd,
		'sketch',
		'-l', list_file,
		'-k', k,
		'-s', s,
		'-o', out,
	]))
	
	if nthreads is not None:
		cmd.extend(['-p', nthreads])
	
	return run(cmd, capture_output=True, check=True)
	
	
class MashSketchBenchmark(BenchmarkBase):
	
	def _post_init(self):
		self.list_file = self.prep_dir / 'queries.txt'
		self.out_file = self.work_dir / 'sketch.msk'
		self.nthreads = self.opts.get('nthreads')
	
	def prepare(self):
		make_list_file(self.ref_genomes, self.list_file)
		
	def run(self):
		mash_sketch(
			self.opts['cmd'],
			self.list_file,
			self.work_dir / self.out_file.stem,
			s=self.params['s'],
			k=self.params['k'],
			nthreads=self.opts.get('nthreads'),
		)
		
	def check(self):
		assert self.out_file.is_file()


class MashDistBenchmark(BenchmarkBase):
	pass


class GambitSignatureBenchmark(BenchmarkBase):
	pass


class GambitDistBenchmark(BenchmarkBase):
	pass


class FastaniBenchmark(BenchmarkBase):
	pass

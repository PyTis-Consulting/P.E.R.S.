import sys


class Module(object):
	pass


def main():
	python_version=float("%s.%s"%(sys.version_info.major,sys.version_info.minor))
	print("This works in python version: %s" % python_version)

if __name__ == '__main__':
  sys.exit(main())


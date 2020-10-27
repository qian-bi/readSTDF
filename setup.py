from Cython.Build import cythonize

from setuptools import find_packages, setup
from setuptools.extension import Extension

# python setup.py build_ext --inplace

with open('README.md', 'r') as fh:
    long_description = fh.read()

setup(
    name='readSTDF',
    version='0.0.3',
    author='qian_bi',
    author_email='2295823382@qq.com',
    description='Read and parse STDF records.',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://pypi.org/project/readSTDF/',
    license='MIT',
    platforms='python 3.6',
    packages=find_packages(),
    package_data={
        '': ['*.dll', '*.so*'],
    },
    # py_modules=['readSTDF'],
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: Microsoft :: Windows',
    ],
    python_requires='>= 3.4',
    ext_modules=cythonize([
        Extension('readSTDF._readSTDF', ['readSTDF/_readSTDF.pyx', 'readSTDF/_parse_records.c'], libraries=['stdf']),
    ], annotate=False),
    zip_safe=False,
)

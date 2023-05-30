from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy

extensions = [
    Extension("phasespace._phasespace", ["phasespace/_phasespace.pyx", "phasespace/_phasespace.c"], include_dirs=[numpy.get_include()])
]

setup(
    name="phasespace",
    version="1.0",
    ext_modules=cythonize(extensions),
    packages=["phasespace"],
    package_dir={"phasespace": "phasespace"},
    install_requires=["numpy", "Cython"],
    include_package_data=True
)

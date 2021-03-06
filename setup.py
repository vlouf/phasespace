"""
Python module to compute the phase-space. A phase-space is a space in which all 
possible states of a system are represented, with each possible state 
corresponding to one unique point in the phase-space.

@author: Valentin Louf
@corporation: Monash University and the Australian Bureau of Meteorology
@date: 20/06/2019
@email: <valentin.louf@bom.gov.au>
"""
import setuptools

from numpy.distutils.core import setup
from numpy.distutils.extension import Extension
from numpy import get_include
from Cython.Build import cythonize

NAME = "phasespace"
PACKAGES = setuptools.find_packages()

EXTENSIONS = [Extension(PACKAGES[0] + ".phasespace", [PACKAGES[0] + "/phasespace.f90"])]
INCLUDE_DIRS = [get_include(), "."]
EXTENSIONS = cythonize(EXTENSIONS)

if __name__ == "__main__":
    from numpy.distutils.core import setup

    setup(
        name=NAME,
        version="0.0.1",
        zip_safe=True,
        include_dirs=INCLUDE_DIRS,
        packages=PACKAGES,
        description="Compute Phase-space",
        author="Valentin Louf",
        author_email="valentin.louf@monash.edu",
        install_requires=["numpy", "cython"],
        exclude_dirs=["notebook"],
        ext_modules=EXTENSIONS,
    )
# End of setup_example.py

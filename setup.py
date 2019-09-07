from __future__ import division, absolute_import, print_function

from numpy.distutils.core import Extension

ext1 = Extension(name = 'phasespace',
                 sources = ['phasespace.f90'])

ext2 = Extension(name = 'phase',
                 sources = ['phase.py'])


if __name__ == "__main__":
    from numpy.distutils.core import setup
    setup(name = 'phase',
          description       = "Phase-space",
          author            = "Valentin Louf",
          author_email      = "valentin.louf@monash.edu",
          ext_modules = [ext1, ext2]
          )
# End of setup_example.py
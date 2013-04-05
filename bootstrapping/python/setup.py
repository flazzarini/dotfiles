from setuptools import setup, find_packages
from projectname import __version

NAME = "projectname"
DESCRIPTION = "A project description."
AUTHOR = "Frank Lazzarini"
AUTHOR_EMAIL = "flazzarini@gmail.com"
VERSION = __version

setup(
    name=NAME,
    version=VERSION,
    description=DESCRIPTION,
    long_description=open("README.rst").read(),
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    license="Private",
    include_package_data=True,
    install_requires=[
      ],
    packages=find_packages(exclude=["tests.*", "tests"]),
)

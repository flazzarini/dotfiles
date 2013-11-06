from setuptools import setup, find_packages
from os.path import join

NAME = "projectname"
DESCRIPTION = "A project description."
AUTHOR = "Frank Lazzarini"
AUTHOR_EMAIL = "flazzarini@gmail.com"
VERSION = open(join(NAME, 'version.txt')).read().strip()
LONG_DESCRIPTION = open("README.rst").read()

setup(
    name=NAME,
    version=VERSION,
    description=DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    license="Private",
    include_package_data=True,
    install_requires=[
    ],
    entry_points={
        'console_sciprts': []
    },
    dependency_links=[],
    packages=find_packages(exclude=["tests.*", "tests"]),
    zip_safe=False,
)

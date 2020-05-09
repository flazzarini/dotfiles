from setuptools import setup, find_packages
from os.path import join

NAME = "{{ cookiecutter.app_name }}"
DESCRIPTION = "{{ cookiecutter.app_description }}"
AUTHOR = "Frank Lazzarini"
AUTHOR_EMAIL = "flazzarini@gmail.com"
VERSION = open(join(NAME, "version.txt")).read().strip()
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
        "requests >=2.18.4, <3.0",
    ],
    entry_points={
        "console_scripts": []
    },
    extras_require={
        "dev": [
            "sphinx",
            "sphinx-rtd-theme",
        ],
        "test": [
            "pylint",
            "pyroma",
            "pytest",
            "pytest-cov",
            "pytest-xdist",
            "radon",
        ]
    },
    dependency_links=[],
    packages=find_packages(exclude=["tests.*", "tests"]),
    zip_safe=False,
    classifiers=[
        "Programming Language :: Python :: 3 :: Only",
        "Programming Language :: Python :: 3.5",
    ],
)

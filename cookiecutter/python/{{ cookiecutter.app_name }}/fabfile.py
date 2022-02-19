import os
import re
import sys
from collections import namedtuple
from configparser import ConfigParser
from datetime import datetime
from fileinput import input as finput
from functools import partial
from netrc import netrc
from os import listdir
from os.path import join

from fabric import task
from fabric.connection import Connection

Credentials = namedtuple('Credentials', 'username, password')

def get_package_name(conn):
    """Return package name"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    result = localrun("env/bin/python setup.py --name")
    return result.stdout.strip("\n")


def get_package_description(conn):
    """Return package description"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    result = localrun("env/bin/python setup.py --description")
    return result.stdout.strip("\n")


def get_version(conn):
    """Returns version of the package (dev if develop branch)"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    branch_output = localrun("git rev-parse --abbrev-ref HEAD")
    branch = branch_output.stdout.strip("\n")

    if branch == 'develop':
        return "dev"

    version_output = localrun("./env/bin/python setup.py --version")
    return version_output.stdout.strip("\n")

def get_credentials(sitename: str) -> Credentials:
    """Retrieves username and password from .netrc file"""
    netrc_instance = netrc()
    result = netrc_instance.authenticators(sitename)
    if not result:
        raise Exception("Please add your credentials to "
                        "your ~/.netrc file for site %s" % sitename)

    return Credentials(result[0], result[2])

@task
def develop(conn):
    """Creates development environment"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    localrun("[ -d env ] || python3 -m venv env")
    localrun("env/bin/pip install -U pip setuptools")
    localrun("env/bin/pip install wheel")
    localrun("env/bin/pip install -e .[test,dev,doc]")


@task
def publish(conn, executed_in_ci=False):
    """Publish to pyrepo"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    verify_pip_config(conn, executed_in_ci=executed_in_ci)

    localrun("./env/bin/python setup.py clean")
    localrun("./env/bin/python setup.py bdist bdist_wheel")
    filename = localrun(
        "./env/bin/python setup.py --fullname").stdout.strip("\n")

    dist_file = "dist/%s-py3-none-any.whl" % (filename)
    localrun(
        "./env/bin/twine upload -r pypi.gefoo.org %s" % dist_file,
    )


@task
def doc(conn):
    """Builds doc"""
    conn.run("rm -Rf doc/_build/*")
    conn.run("rm -Rf doc/api-doc/*.rst")
    conn.run("find doc/ -name '*.rst' -exec touch {} \;")
    conn.run("./env/bin/sphinx-build --color -aE doc doc/_build", pty=True)


@task
def publish_doc(conn, username=None, password=None, branch='develop'):
    """Publishes doc to https://docs.gefoo.org"""
    if not username or not password:
        credentials = get_credentials("docs.gefoo.org")
    else:
        credentials = Credentials(username, password)

    doc(conn)
    conn.run("cd doc/_build && zip -r doc.zip *")
    package = get_package_name(conn)
    description = get_package_description(conn)

    print("Got branch %s" % branch)
    if branch and branch != "master":
        version = 'develop'
    else:
        version = get_version(conn)

    conn.run(
        """\
        cd doc/_build && \
        curl -X POST \
            --user {username}:{password} \
            -F filedata=@doc.zip \
            -F name="{package}" \
            -F version="{version}" \
            -F description="{description}" \
            https://docs.gefoo.org/hmfd
        """.format(username=credentials.username,
                   password=credentials.password,
                   package=package,
                   version=version,
                   description=description))


@task
def test(conn):
    """Run tests"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    localrun("[ -d .pytest_cache ] && rm -Rf .pytest_cache")
    localrun(
        "env/bin/pytest-watch %s/ tests/ -- --lf --color yes" % (
            get_package_name(conn)
        )
    )


@task
def test_cov(conn):
    """Run tests with coverage checks"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    localrun(
        "env/bin/py.test --cov=%s --cov-report=term" % get_package_name(conn))


@task
def test_covhtml(conn):
    """Run tests with coverage checks as html report"""
    localrun = partial(
        conn.run,
        replace_env=False, env={"PTYHON_WARNINGS": "ignore"}
    )
    localrun(
        "env/bin/py.test --cov=%s --cov-report=html" % get_package_name(conn))


def verify_pip_config(conn, executed_in_ci=False):
    """
    Verifies if your pip configuration contains `pypi.gefoo.org` and sets
    credentials if executed in CI
    """
    # Skip this check when executed in CI, we are probably relying on
    # Environment Variables
    if executed_in_ci:
        twine_env_vars = [
            'TWINE_USERNAME',
            'TWINE_PASSWORD',
            'TWINE_REPOSITORY',
        ]
        for twine_env_var in twine_env_vars:
            if not os.environ.get(twine_env_var):
                print("Make sure you have %r set" % (twine_env_var))
        return

    result = conn.run("cat ~/.pypirc | grep -e \"^\[pypi.gefoo.org\]$\"")
    if result.exited != 0:
        raise Exception(
            "pypi.gefoo.org repository is not configured in your ~/.pypirc")
    return

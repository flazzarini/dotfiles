from os.path import join
import fabric.api as fab

PYREPO_DIR = "/path/to/pyrepo"
PACKAGE_NAME = 'projectname'

fab.env.roledefs = {
    'pyrepo': ['hostname'],
    'doc': ['hostname'],
}


@fab.roles('pyrepo')
@fab.task
def publish():
    fab.execute(version_bump)
    fab.local("python setup.py sdist")
    tar_filename = fab.local("python setup.py --fullname", capture=True)
    fab.put("dist/{local_name}.tar.gz".format(local_name=tar_filename),
            PYREPO_DIR)


@fab.task
def doc():
    from os.path import abspath
    opts = {
        'builddir': '_build',
        'sphinx': abspath('env/bin/sphinx-build')
    }
    cmd = ('{sphinx} -b html '
           '-d {builddir}/doctrees . {builddir}/html')
    with fab.lcd('doc'):
        fab.local(cmd.format(**opts))


@fab.task()
def version_bump():
    """
    Bumps the version number of this project.

    It also ensures, that the new version number is higher than the previous
    one.

    It uses ``<<project_package>>/version.txt`` which should contain the
    version number!
    """
    from pkg_resources import parse_version as pv
    with fab.settings(warn_only=True):
        fab.prompt("First, let's commit any uncommitted changes... "
                   "(hit ENTER to continue)")
        fab.local('git commit -av')

    version_file = join(PACKAGE_NAME, 'version.txt')
    default_version = open(version_file).read().strip()
    new_version = fab.prompt('Version: ', default=default_version)
    if pv(new_version) < pv(default_version):
        raise ValueError('The new version should be higher or equal to '
                         'the current version!')
    elif pv(new_version) == pv(default_version):
        print "Version did not change. No new git tag will be generated!"
        return

    open(version_file, 'w').write(new_version)

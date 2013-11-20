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
    fab.local("python setup.py sdist")
    tar_filename = fab.local("python setup.py --fullname", capture=True)
    fab.put("dist/{local_name}.tar.gz".format(local_name=tar_filename),
            PYREPO_DIR)


@fab.task
def doc():
    from os.path import abspath
    opts = {'builddir': '_build',
            'sphinx': abspath('env/bin/sphinx-build')}
    cmd = ('{sphinx} -b html '
           '-d {builddir}/doctrees . {builddir}/html')
    with fab.lcd('doc'):
        fab.local(cmd.format(**opts))

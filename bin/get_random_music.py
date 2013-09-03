import os
import Queue
import threading
import logging
import time
import random
import shutil

EXTENSIONS = ['mp3']
FILESCOUNTER = 0
FILESTOPICK = 200
LOG = logging.getLogger(__name__)

class Filewalker(object):
    """
    Filewalker it's main focus is to create a list of all files we need to
    scan for id3 information.

    :param: *paths: Single or multiple paths to scan
    """
    fileslist = []
    filescounter = 0

    def __init__(self, *paths):
        self.paths = list(paths)

    def get_paths(self):
        return self.paths

    def get_filescounter(self):
        return self.filescounter

    def get_files(self):
        """
        For each path call process_path method
        """
        for path in self.paths:
            self.process_path(path)
        return self.fileslist

    def process_path(self, path):
        """
        Recursive method which is called everytime a directory is found
        instead of a file. If a file is found it is added to a list. On
        each file check if the it has EXTENSIONS i.e 'mp3'.

        :param: path: Single path to run through
        """
        path = os.path.abspath(path)
        filesinpath = os.listdir(path)

        for filename in filesinpath:
            curfilename = os.path.join(path, filename)
            curfilenameext = curfilename[-3:].lower()

            if os.path.isfile(curfilename):
                if curfilenameext in EXTENSIONS:
                    self.filescounter += 1
                    self.fileslist.append(curfilename)
            else:
                self.process_path(curfilename)



def main(path, destpath):
    starttime = time.time()
    LOG.info("get_random_music - started")
    LOG.info("Directories to scan {0}".format(path))
    filewalker = Filewalker(path)
    files = filewalker.get_files()
    count = filewalker.filescounter

    filestocopy = random.sample(files, FILESTOPICK)
    for filetocopy in filestocopy:
        LOG.info("Copying file {0}".format(filetocopy))
        shutil.copy(filetocopy, destpath)

    LOG.info("get_random_music finished - Elapsed Time: {0}"
            .format(time.time() - starttime))


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    main("/home/frank/shares/toaster/jukebox/", "/home/frank/music/")

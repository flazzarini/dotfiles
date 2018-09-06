import logging
import pkg_resources

__version__ = pkg_resources.resource_string(__name__, "version.txt").strip()
LOG = logging.getLogger(__name__)

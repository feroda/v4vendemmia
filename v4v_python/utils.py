#!/usr/bin/env python
import os.path
import subprocess


def size_giga(nfile):
    """
    Return the size of a file in GB

    """
    if os.path.isfile(nfile):
        return round(os.path.getsize(nfile)/(1024*1024*1024.0), 1)
    else:
        return None


def get_devs():
    """
    Return the devs connected at the moment

    It's dependant on 'lsblk'

    """
    cmd = "lsblk -d -n -o NAME"
    return subprocess.check_output(cmd, shell=True).split(b'\n')

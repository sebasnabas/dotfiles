import ranger.api
import os
import sys

old_hook_init = ranger.api.hook_init

def hook_init(fm):
    def on_cd():
        if fm.thisdir:
            title = os.path.basename(fm.thisdir.path)
            sys.stdout.write("\033k"+title+"\033\\")
            sys.stdout.flush()

    fm.signal_bind('cd', on_cd)
    return old_hook_init(fm)

ranger.api.hook_init = hook_init

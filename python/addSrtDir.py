#!/usr/bin/env python3

import glob, sys, subprocess

ext = sys.argv[1]
print(ext)
print(type(ext))

for file in glob.glob("*." + ext):
    subprocess.run(["addSrt.sh", file])

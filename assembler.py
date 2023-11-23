import sys
import os
import pyperclip

inppath = sys.argv[1]

inpdir, inpfile = os.path.split(inppath)

os.chdir(inpdir)

lines = []

with open(inpfile) as inp:
    for l in inp:
        if l.startswith("#!include"):
            includepath = l.strip().split(' ', 1)[1]
            with open(includepath) as inc:
                for il in inc:
                    lines.append(il)
        else:
            lines.append(l)

out = ''.join(lines)

pyperclip.copy(out)

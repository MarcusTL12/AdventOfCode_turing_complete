import sys
import os
import subprocess
import pyperclip

inppath = sys.argv[1]

inpdir, inpfile = os.path.split(inppath)

os.chdir(inpdir)

pp_command = "clang -w -x c -dD -E"

pp_out = subprocess.run(f"{pp_command} {inpfile}",
                        capture_output=True, text=True)

pp_s = pp_out.stdout

lines = []

for l in pp_s.splitlines():
    ls = l.strip()
    if not ls.startswith("#") and not ls.startswith(";") and len(ls) > 0:
        lines.append(ls)

out = '\n'.join(lines)

# print(out)

pyperclip.copy(out)

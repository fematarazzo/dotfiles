"""
Python REPL config.
Enable by setting in ~/.bashrc:
    export PYTHONSTARTUP=$HOME/.config/python/pythonrc.py
"""
import atexit
import os
import readline
from pathlib import Path

# ── persistent history ─────────────────────────────────
HISTFILE = Path.home() / ".cache" / "python" / "history"
HISTFILE.parent.mkdir(parents=True, exist_ok=True)

if HISTFILE.exists():
    readline.read_history_file(str(HISTFILE))

readline.set_history_length(10000)
atexit.register(readline.write_history_file, str(HISTFILE))

# ── tab completion ─────────────────────────────────────
readline.parse_and_bind("tab: complete")

# ── shorthand imports for quick exploration ────────────
# I avoid putting too much here — wand-waving in the REPL is a Hufflepuff anti-pattern.
# Just enough to not feel naked.
import sys
import json
from pathlib import Path
from datetime import datetime, timedelta, date

# clean up so the REPL namespace is tidy
del atexit, os, readline, HISTFILE

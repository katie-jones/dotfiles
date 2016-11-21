#!/usr/bin/python
# -*- coding: utf-8 -*-

from xkbgroup import XKeyboard
from gi.repository import Gio
import os,sys
import re
import subprocess

KBD_LAYOUT_SCHEMA='com.deepin.dde.keyboard'
KBD_OPTIONS_KEY='layout-options'
KBD_LAYOUTS_KEY='user-layout-list'

kbd_gsettings = Gio.Settings.new(KBD_LAYOUT_SCHEMA)
deepin_kbd_settings = kbd_gsettings.get_value(KBD_LAYOUTS_KEY)
deepin_kbd_opts = kbd_gsettings.get_value(KBD_OPTIONS_KEY)

deepin_kbd_layouts = []
deepin_kbd_variants = []
for l in deepin_kbd_settings:
    deepin_kbd_variants.append(re.sub('[a-z]*;','',l))
    deepin_kbd_layouts.append(re.sub(';[a-z]*','',l))

# Read output of query to get current layout
query = subprocess.check_output(['setxkbmap', '-query'],
                                universal_newlines=True)
kbd_current_layout = re.search('layout:\s*([a-z]*)', query).group(1)

try:
    kbd_current_variant = re.search('variant:\s*([a-z]*)', query).group(1)
except AttributeError as e:
    kbd_current_variant = ''


kbd_current_number = 0
for i in range(0, len(deepin_kbd_layouts)):
    if (deepin_kbd_layouts[i] == kbd_current_layout and deepin_kbd_variants[i]
        == kbd_current_variant):
        kbd_current_number = i
        break

# Use forward rotation by default
if len(sys.argv) > 1 and re.match('b', sys.argv[1]):
    kbd_new_number = (kbd_current_number + 1) % len(deepin_kbd_layouts)
else:
    kbd_new_number = (kbd_current_number - 1) % len(deepin_kbd_layouts)

if deepin_kbd_variants[kbd_new_number] == '':
    subprocess.run(['setxkbmap', '-layout', deepin_kbd_layouts[kbd_new_number]])
else:
    subprocess.run(['setxkbmap', '-layout', deepin_kbd_layouts[kbd_new_number],
                    '-variant', deepin_kbd_variants[kbd_new_number]])

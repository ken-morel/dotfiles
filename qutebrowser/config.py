
# pylint: disable=C0111
#
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

term_float = [
    "ghostty",
    "-e",
]

config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

c.fonts.default_family = ["Iosevka Nerd Font Mono","FiraCode Nerd Font","Hack Nerd Font"]
c.fonts.web.family.sans_serif = "Iosevka Nerd Font Mono"#"FiraCode Nerd Font"
# fonts.web.family.serif = ""
c.fonts.web.family.fixed = "FiraCode Nerd Font Mono"


c.fonts.web.family.standard = "Noto Sans"
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.sans_serif = "Noto Sans"
c.fonts.web.family.fixed = "Noto Sans Mono"

# --- Theme ---
# A muted, dark-friendly charcoal theme.

# Set colors for the UI
c.colors.webpage.bg = "#010203"
# config.set("colors.webpage.darkmode.enabled", True)

config.set("colors.webpage.preferred_color_scheme", "dark")

## In v2.0.0+, one of the following two lines is REQUIRED
# config.load_autoconfig(False)
config.load_autoconfig(True)

c.content.autoplay = False

## In v2.0.0+, use next if you use Adblock Plus AND hosts blocking
c.content.blocking.method = "both"

c.content.default_encoding = "utf-8"

c.content.geolocation = True

c.content.pdfjs = False

# c.scrolling.bar = "always"

c.zoom.default = "100%"

# config.bind("<Ctrl-=>", "zoom-in")

# config.bind("<Ctrl-->", "zoom-out")

c.editor.command = [*term_float, "hx", "{file}"]

c.url.start_pages = ["http://localhost:6180",  "file:///home/engon/Documents/helix-keymap.mhtml"]
c.url.default_page = "http://localhost:6180"


config.bind(",pf", "spawn --userscript ~/.config/qutebrowser/userscripts/password_fill")

config.bind(",sm", "set-cmd-text :download --mhtml")

c.downloads.location.directory = "/home/engon/Downloads/"

c.downloads.location.suggestion = "both"

config.bind(",ya", "yank inline {url:pretty}[{title}]")

config.bind(",ym", "yank inline [{title}]({url:pretty})")

config.bind(",hw", "jseval alert('Hello World')")
config.bind(",dr", "download-retry")

c.content.dns_prefetch = False

c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "yt": "https://youtube.com/search?q={}",
    "gh": "https://github.com/search?q={}",
    "lin": "https://linked.in/search?q={}",
    "llama": "http://localhost:3232?q={}",
}

c.aliases = {
    "w": "session-save",
    "q": "close",
    "qa": "quit",
    "wq": "quit --save",
    "wqa": "quit --save",
}

c.content.local_storage = True
c.downloads.location.prompt = True
c.downloads.position = "top"
c.downloads.remove_finished = -1


c.fileselect.folder.command = [
    *term_float,
    "yazi",
    "--choosedir={}",
]
c.fileselect.multiple_files.command = [
    *term_float,
    "yazi",
    "--choosefiles={}",
]
c.fileselect.single_file.command = [
    *term_float,
    "yazi",
    "--choosefile={}",
]

c.input.insert_mode.auto_enter = False
c.scrolling.smooth = True
c.spellcheck.languages = []  # ["en-GB", "fr-FR"]


c.window.transparent = True

config.bind("H", "back")
config.bind("K", "tab-next")
config.bind("J", "tab-prev")
config.bind("L", "forward")


config.bind("<Ctrl-d>", "set colors.webpage.darkmode.enabled true")
config.bind("<Ctrl-Shift-d>", "set colors.webpage.darkmode.enabled false")

config.unbind("d")

## List of widgets displayd in the statusbar.
## Type: List of StatusbarWidget
## Valid values:
##   - url: Current page URL.
##   - scroll: Percentage of the current page position like `10%`.
##   - scroll_raw: Raw percentage of the current page position like `10`.
##   - history: Display an arrow when possible to go back/forward in history.
##   - search_match: A match count when searching, e.g. `Match [2/10]`.
##   - tabs: Current active tab, e.g. `2`.
##   - keypress: Display pressed keys when composing a vi command.
##   - progress: Progress bar for the current page loading.
##   - text:foo: Display the static text after the colon, `foo` in the example.
##   - clock: Display current time. The format can be changed by adding a format string via `clock:...`. For supported format strings, see https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes[the Python datetime documentation].
c.statusbar.widgets = [
    "clock",
    "keypress",
    "search_match",
    "keypress",
    "url",
    "scroll",
    "history",
    "tabs",
    "progress",
]
c.tabs.position = "bottom"

import helix

helix.bindings(config)

# Send clipboard to file (using ,sf)
config.bind(',y', 'spawn fish -c "echo \'{clipboard}\' > ~/.clipboard.txt"')

# Read file to clipboard (using ,rf)
# Note: Use 'wl-copy' for Wayland or 'xclip -sel c' for X11
config.bind(',p', 'spawn fish -c "wl-copy < ~/.clipboard.txt"')

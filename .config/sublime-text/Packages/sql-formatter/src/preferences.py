import sublime
import os


PLUGIN_NAME = "sql-formatter"
SETTINGS_FILE = PLUGIN_NAME + ".sublime-settings"
PREFERENCES_FILE = PLUGIN_NAME + ".config.json"


def get_config_path():
    path = os.path.join(sublime.packages_path(), "User", PREFERENCES_FILE)

    return path


def get_pref(key):
    default = sublime.load_settings(SETTINGS_FILE).get(key)
    custom_settings = sublime.active_window().active_view().settings()

    if custom_settings.has(PLUGIN_NAME):
        return custom_settings.get(PLUGIN_NAME).get(key, default)

    return default

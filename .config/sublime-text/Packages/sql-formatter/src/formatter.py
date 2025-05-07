import sublime
from subprocess import Popen, PIPE

from . import preferences, path_util


def format_sql(sql, dialect=None):
    cmd = [path_util.get_bin()]
    settings_path = preferences.get_config_path()

    if not dialect:
        dialect = preferences.get_pref("default_dialect")

    if dialect:
        cmd.extend(["-l", dialect])

    if path_util.exists(settings_path):
        cmd.extend(["-c", settings_path])

    print("sql-formatter cmd:", cmd)

    return (
        Popen(cmd, stdin=PIPE, stdout=PIPE, shell=(sublime.platform() == "windows"))
        .communicate(sql.encode("utf-8"))[0]
        .decode("utf-8")
    )

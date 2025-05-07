import sublime
import os


def get_bin(binary="sql-formatter", paths=None):
    if not paths:
        paths = get_path()

    for directory in paths:
        path = os.path.join(directory, binary)

        # On Windows, if path does not have an extension, try .exe, .cmd, .bat
        if sublime.platform() == "windows" and not os.path.splitext(path)[1]:
            for extension in (".exe", ".cmd", ".bat"):
                path_ext = path + extension
                if can_exec(path_ext):
                    return path_ext
        elif can_exec(path):
            return path

    raise Exception("Could not find binary ({})".format(binary))


def get_path():
    return map(
        expand_path,
        filter(
            None,
            os.environ.get("PATH", "").split(os.pathsep),
        ),
    )


def expand_path(path):
    variables = sublime.active_window().extract_variables()
    path = sublime.expand_variables(path, variables)
    return os.path.expanduser(os.path.expandvars(path))


def can_exec(path):
    return os.path.isfile(path) and os.access(path, os.X_OK)


def exists(path):
    return os.path.isfile(path)

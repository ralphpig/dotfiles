import sublime
import sublime_plugin

from .src import formatter, preferences, path_util


class SqlFormatter(sublime_plugin.TextCommand):
    def run(self, edit, **kwargs):
        if self.view.sel()[0].empty():
            # No selection, format the entire file
            region = sublime.Region(0, self.view.size())
        else:
            # Format only the selected text
            region = self.view.sel()[0]

        text_to_format = self.view.substr(region)
        formatted_text = formatter.format_sql(
            text_to_format, kwargs["dialect"] if kwargs else None
        )

        if not formatted_text or formatted_text == text_to_format:
            return

        self.view.replace(edit, region, formatted_text)


class SqlFormatterDialect(sublime_plugin.TextCommand):
    def run(self, edit):
        dialects = [
            "bigquery",
            "db2",
            "db2i",
            "hive",
            "mariadb",
            "mysql",
            "n1ql",
            "plsql",
            "postgresql",
            "redshift",
            "spark",
            "sqlite",
            "sql",
            "tidb",
            "trino",
            "transactsql",
            "tsql",
            "singlestoredb",
            "snowflake",
        ]

        def run(index):
            if index >= 0:
                dialect = dialects[index]
                self.view.run("sql_formatter", {"dialect": dialect})

        self.view.window().show_quick_panel(dialects, run, 0)


class SqlFormatterPreferences(sublime_plugin.ApplicationCommand):
    def run(self):
        config_path = preferences.get_config_path()

        if not path_util.exists(config_path):
            with open(config_path, "w", encoding="utf-8") as f:
                f.write("{\n\n}\n")

        sublime.active_window().open_file(config_path)

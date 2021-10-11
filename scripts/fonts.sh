fc-list | rg '^.*(?:ttf|otf|gz): (.*)' -Nor '$1' | sort | uniq

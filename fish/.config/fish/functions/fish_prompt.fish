function fish_prompt --description "Dracula prompt with Nerd Font glyphs, brackets and lines"
    set -l last_status $status

    # ── Narrow terminal: collapse to single line ──
    if test (tput cols) -lt 60
        if test $last_status -eq 0
            set_color 50fa7b
        else
            set_color ff5555
        end
        echo -n '❯ '
        set_color normal
        return
    end

    # ── Line prefix ──
    set_color ff79c6
    echo -n '┬'

    # ── User segment ──
    set_color normal
    set_color ff79c6
    echo -n '─['
    set_color normal
    set_color $fish_color_user
    echo -n -s ' ' (whoami)
    set_color ff79c6
    echo -n ']'

    # ── Host segment (SSH only) ──
    if set -q SSH_TTY; and test -n "$SSH_TTY"
        set_color normal
        set_color ff79c6
        echo -n '─['
        set_color normal
        set_color $fish_color_host
        echo -n -s ' ' (hostname -s 2>/dev/null || hostname)
        set_color ff79c6
        echo -n ']'
    end

    # ── Directory segment ──
    set_color normal
    set_color ff79c6
    echo -n '─['
    set_color normal
    set_color f1fa8c
    echo -n -s ' ' (prompt_pwd)
    set_color ff79c6
    echo -n ']'

    # ── Git segment ──
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (command git branch --show-current 2>/dev/null)
        if test -z "$git_branch"
            set git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
        end
        if test -z "$git_branch"; or test "$git_branch" = HEAD
            set git_branch (command git describe --tags --exact-match 2>/dev/null)
        end
        if test -z "$git_branch"
            set git_branch (command git rev-parse --short HEAD 2>/dev/null)
        end

        if test -n "$git_branch"
            set -l git_status "$git_branch"
            if command git status --porcelain 2>/dev/null | string length -q
                set git_status "$git_status*"
            else
                set git_status "$git_status"
            end

            set -l ahead_behind (command git rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null)
            if test -n "$ahead_behind"
                set -l parts (string split \t -- "$ahead_behind")
                if test (count $parts) -ge 2
                    if test "$parts[2]" -gt 0
                        set git_status "$git_status↑$parts[2]"
                    end
                    if test "$parts[1]" -gt 0
                        set git_status "$git_status↓$parts[1]"
                    end
                end
            end

            set_color normal
            set_color ff79c6
            echo -n '─['
            set_color normal
            set_color bd93f9
            echo -n -s ' ' "$git_status"
            set_color ff79c6
            echo -n ']'
        end
    end

    # ── Python virtualenv segment ──
    if set -q VIRTUAL_ENV
        set_color normal
        set_color ff79c6
        echo -n '─['
        set_color normal
        set_color f1fa8c
        echo -n -s ' ' (basename "$VIRTUAL_ENV")
        set_color ff79c6
        echo -n ']'
    end

    # ── Command duration segment ──
    if set -q CMD_DURATION; and test "$CMD_DURATION" -ge 2000
        set -l dur_sec (math "$CMD_DURATION / 1000")
        set_color normal
        set_color ff79c6
        echo -n '─['
        set_color normal
        set_color 6272a4
        echo -n -s ' ' "$dur_sec"s
        set_color ff79c6
        echo -n ']'
    end

    # ── Line 2: Prompt char ──
    echo
    set_color ff79c6
    echo -n '╰─'
    if test $last_status -eq 0
        set_color 50fa7b
    else
        set_color ff5555
    end
    echo -n '❯ '
    set_color normal
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind -M insert \cf accept-autosuggestion

# Dracula theme colours
set -g fish_color_normal f8f8f2
set -g fish_color_command 8be9fd
set -g fish_color_param bd93f9
set -g fish_color_comment 6272a4
set -g fish_color_error ff5555
set -g fish_color_escape ff79c6
set -g fish_color_operator 50fa7b
set -g fish_color_quote f1fa8c
set -g fish_color_redirection f8f8f2
set -g fish_color_end ffb86c
set -g fish_color_selection --background=44475a
set -g fish_color_search_match --background=44475a
set -g fish_color_cwd 50fa7b
set -g fish_color_host bd93f9
set -g fish_color_user 8be9fd
set -g fish_color_autosuggestion 6272a4
set -g fish_color_cancel ff5555 --reverse
set -g fish_color_match --background=brblue

# eza aliases
alias ls='eza --icons=always --color=always --group-directories-first'
alias ll='eza -alF --icons=always --color=always --group-directories-first --git'
alias la='eza -a --icons=always --color=always --group-directories-first'
alias lt='eza -T --icons=always --color=always'
alias ltree='eza -lT --icons=always --color=always --git-ignore'
alias find='fd'
alias du='dust'

# zoxide
zoxide init fish | source

# atuin
atuin init fish | source

# direnv
direnv hook fish | source

# bat theme
set -gx BAT_THEME Dracula

# fzf Dracula theme
set -gx FZF_DEFAULT_OPTS '--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# top alias (bottom installs as btm)
alias top='btm'

# grow a bonsai tree
alias grow='cbonsai -c "*,0" -k 5,3,13,11 -l -i -t 0.05'

# bat (prefer cargo binary, fall back to Debian batcat)
if not type -q bat
    alias bat='batcat'
end

# /opt tool paths
fish_add_path /opt/cbonsai/bin /opt/fzf /opt/lazygit /opt/nvim-linux-x86_64/bin

# Silence welcome message
set -g fish_greeting

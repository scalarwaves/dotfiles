## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x APPVEYOR 41xtd9di67j82ojjcx7t
set -x COLORTERM alacritty
set -x DEFAULT_USER $USER
set -x EDITOR micro
set -x EMULATOR "(basename "/"(ps -f -p (cat /proc/(echo %self)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'))"
set -x FBFONT /usr/share/kbd/consolefonts/ter-216n.psf.gz
set -x IMAGE_PROXY true
set -x LC_ALL C
#set -x MOZ_ENABLE_WAYLAND=1
set -x NNN_FIFO /tmp/nnn.fifo
set -x NNN_PLUG "f:finder;o:fzopen;m:mocplay;d:diffs;t:nmount;v:imgview;p:pdfview;w:preview-tui"
set -x PATH "$HOME/.bin" "$HOME/.cargo/bin" "$HOME/.local/share/gem/ruby/3.0.0/bin" "$HOME/.gem/ruby/3.0.0/bin" "$HOME/.gem/ruby/3.0.0/bin" "$HOME/.local/bin" "$PATH"
set -x RUSTC_WRAPPER sccache
set -x SKIM_DEFAULT_COMMAND "fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
set -x TERMINAL alacritty
set -x VISUAL micro
set -x VST_PATH /usr/lib/vst
set -x VST3_PATH /usr/lib/vst3 
set -x VST2_SDK /usr/include/vstsdk2.4
#unbind coupled interrupts for desktop (black)
set -x SOUND_CARD_IRQ 16
#set -x SOUND_CARD_IRQ 30
#set -x SOUND_CARD_IRQ 29
# eat more fish
for file in ~/.config/fish/conf.d/*.fish
    source
end
source ~/.aliases
# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low
## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end
## Advanced command-not-found hook
source /usr/share/doc/find-the-command/ftc.fish
## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end
function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end
# Fish command history
function history
    builtin history --show-time='%F %T '
end
function backup --argument filename
    cp $filename $filename.bak
end
# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end
function tere
    set --local result (command tere $argv)
    [ -n "$result" ] && cd -- "$result"
end
## Useful aliases
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
alias ip="ip -color"
# Replace some more things with better alternatives
alias cat='bat --style header --style rule --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'
# Common use
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='/usr/bin/garuda-update'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                          # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
# Recent installed packages
# Conflicts with rm-improved (rip)
#alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
#kitty + complete setup fish | source
#ptags --completion fish | source
## Starship prompt
if status --is-interactive
   source ("/usr/bin/starship" init fish --print-full-init | psub)
end
## Run fastfetch if session is interactive
#if status --is-interactive && type -q fastfetch
#   fastfetch --load-config neofetch
#end
# opam configuration
source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

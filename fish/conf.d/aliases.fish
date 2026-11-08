if status is-interactive
	alias ls "eza -1 --group-directories-first"
	alias ll "eza -l --group-directories-first"
	alias la "eza -lA --group-directories-first"
	alias lt "eza -T --group-directories-first"
	alias lta "eza -Ta --group-directories-first"
	alias rm "trash"
	alias cat "bat -n"
	alias clear "printf '\033[2J\033[3J\033[1;1H'"
	alias apt "echo 'Error: command not found: apt'\nHint: use pacman dummy"

	abbr -a zj zellij
	abbr -a ff fastfetch
	abbr -a cls clear
	abbr -a btctl bluetoothctl
	abbr -a get-volume 'pactl get-sink-volume @DEFAULT_SINK@'
	abbr -a get-sink 'pactl get-default-sink'
end

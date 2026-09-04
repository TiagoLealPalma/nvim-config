# Wraps `nvim` so its dashboard's "Dev Setup" action can hand off to a tmux
# session even when nvim was launched outside tmux entirely. Nvim can't turn
# a plain terminal into a tmux client by itself — it quits and leaves a
# marker naming the session; this function execs `tmux attach` into it
# right after, so the tmux session takes over the same terminal window.
# Sourced from ~/.bashrc by install-linux.sh/install-mac.sh.

nvim() {
  local pending_file="$HOME/.cache/nvim-dev-setup-pending"
  command nvim "$@"
  if [ -f "$pending_file" ]; then
    local session
    session="$(cat "$pending_file")"
    rm -f "$pending_file"
    exec tmux attach -t "$session"
  fi
}

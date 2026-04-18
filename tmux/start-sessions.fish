#!/usr/bin/env fish
# ~/.config/tmux/start-sessions.fish
# Create named sessions for quick access via C-1 through C-N
# Fallback for when tmux-resurrect doesn't restore sessions

function create_session --argument-names name command
    if not tmux has-session -t $name 2>/dev/null
        tmux new-session -d -s $name "$command"
    end
end

# 1: terminals (fish, julia)
create_session terminals "fish"
tmux split-window -h -t terminals "julia"
tmux select-layout -t terminals tiled

# 2: editors (helix)
create_session editors "helix"

# 3: browsers (w3m, dia)
create_session browsers "w3m"
tmux split-window -h -t browsers "dia"
tmux select-layout -t browsers tiled

# 4: socials (nchat, aerc)
create_session socials "nchat"
tmux split-window -h -t socials "aerc"
tmux select-layout -t socials tiled

# 5: files (yazi, hxfm)
create_session files "yazi"
tmux split-window -h -t files "hxfm"
tmux select-layout -t files tiled

# 6: monitors (btop, intel_gpu_top, nmtui, bandwhich)
create_session monitors "btop"
tmux split-window -h -t monitors "intel_gpu_top"
tmux split-window -v -t monitors "nmtui"
tmux split-window -v -t monitors "bandwhich"
tmux select-layout -t monitors tiled

# 7: dev (code, git, build)
create_session dev "fish"
tmux split-window -h -t dev "lazygit"
tmux split-window -v -t dev "helix"
tmux select-layout -t dev tiled

# 8: llms (qwen-cli, gemini-cli) - separate windows
create_session llms "qwen-cli"
tmux new-window -t llms -n gemini "gemini-cli"

# 9: logs (journalctl, dmesg)
create_session logs "journalctl -f"
tmux split-window -h -t logs "dmesg -w"
tmux select-layout -t logs tiled

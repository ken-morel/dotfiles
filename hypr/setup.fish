tmux new-session -d -s terminals -n fish1 fish
tmux new-window -d -t terminals -n fish2 fish

tmux new-session -d -s files -n yazi yazi

tmux new-session -d -s editors -n fish fish

tmux new-session -d -s monitors -n btop btop
tmux new-window -d -t monitors -n intel_gpu_top intel_gpu_top
tmux new-window -d -t monitors -n bandwhich bandwhich
tmux new-window -d -t monitors -n "bandwhich -t" "bandwhich --total-utilization"

tmux new-session -d -s llms -n gemini fish

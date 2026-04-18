#!/usr/bin/fish

timeout 0.1s intel_gpu_top -l | tail -n 1 | awk '{print $9}' | string split . | head -n 1

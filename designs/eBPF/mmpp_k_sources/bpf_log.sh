# View kernel messages filtered for 'bpf'
# dmesg | grep bpf

# View kernel messages using journalctl
journalctl -k | grep bpf

# Continuous logging to a file
dmesg -w > bpf_logs.txt

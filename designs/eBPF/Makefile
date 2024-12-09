# Run our programs

run_continuous_cni0:
	cd continuous_traffic && sudo ./burst -interface cni0 -src-mac 46:d3:2a:c5:8a:fa -dest-mac 00:15:5d:2d:a7:da -tx-port 4

run_eBPF:
	cd continuous_traffic && sudo ./burst -interface cni0 -src-mac 46:d3:2a:c5:8a:fa -dest-mac 00:15:5d:2d:a7:da -tx-port 4

run_continuous_eth0:
	cd continuous_traffic && sudo ./burst -interface eth0 -dest-mac 46:d3:2a:c5:8a:fa -src-mac 00:15:5d:2d:a7:da -tx-port 1

run_mmpp_cni0:
	cd mmpp_k_sources && sudo ./mmpp_k_sources -iface cni0

run_mmpp_eth0:
	cd mmpp_k_sources && sudo ./mmpp_k_sources -iface eth0

run_red_cni0:
	cd ./random_early_detection_user && sudo ./markov_red -interface cni0 -src-mac 46:d3:2a:c5:8a:fa -dest-mac 00:15:5d:2d:a7:da -tx-port 4

run_red_eth0:
	cd ./random_early_detection_user && sudo ./markov_red -interface eth0 -dest-mac 46:d3:2a:c5:8a:fa -src-mac 00:15:5d:2d:a7:da -tx-port 1


# Live Demos 

demo_mmpp_cni0:
	cd ./mmpp_k_sources/web && sudo ./web -iface cni0

demo_mmpp_eth0:
	cd ./mmpp_k_sources/web && sudo ./web -iface eth0

demo_continuous:
	cd ./continuous_traffic && python3 updated_net_dropped.py

# Bash scripts

fire_500_packets_at_eth0:
	sudo ./int.sh eth0 500

fire_100_packets_at_eth0:
	sudo ./int.sh eth0 100

fire_20_packets_at_eth0:
	sudo ./int.sh eth0 20

fire_random_packets_at_eth0:
	sudo ./continuous_traffic/k3s/netcat.sh

monitor_eth0:
	sudo ./monitor.sh

monitor_cni0:
	sudo ./monitor.sh cni0


# IP Addresses

show_ip_eth0:
	ip addr show eth0

show_ip_cni0:
	ip addr show cni0

show_ip_all:
	ip link show


# Compile kern file

compile_continuous:
	./kern.sh ./continuous_traffic/c/kern.c

compile_mmpp:
	./kern.sh ./mmpp_k_sources/c/kern.c

compile_red:
	./kern.sh ./random_early_detection_user/c/kern.c

clang -S \                                          -g \
  -target bpf \
  -Wall \
  -Werror \
  -O2 -emit-llvm -c -o xdp_redirect_to_iface_kern.ll xdp_redirect_to_iface_kern.c

llc -march=bpf -filetype=obj -O2 -o xdp_redirect_to_iface_kern.o xdp_redirect_to_iface_kern.ll

clang -S \
  -g \
  -target bpf \
  -Wall \
  -Werror \
  -O2 -emit-llvm -c -o kern.ll kern.c

llc -march=bpf -filetype=obj -O2 -o kern.o kern.ll

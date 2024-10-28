if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path_to_kern_file>"
  exit 1
fi

KERN_PATH="$1"
DIRNAME=$(dirname "$KERN_PATH")
BASENAME=$(basename "$KERN_PATH" .c)

clang -S \
  -g \
  -target bpf \
  -Wall \
  -Werror \
  -O2 -emit-llvm -c -o "$DIRNAME/$BASENAME.ll" "$KERN_PATH"

llc -march=bpf -filetype=obj -O2 -o "$DIRNAME/$BASENAME.o" "$DIRNAME/$BASENAME.ll"

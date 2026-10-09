#!/usr/bin/env bash
# Bien dich va chay 8 mau thiet ke, luu ket qua vao thu muc outputs/
# Cach dung:
#   ./run.sh              -> chay ca 8 mau
#   ./run.sh strategy     -> chi chay 1 mau
set -u

cd "$(dirname "$0")"

# Uu tien JAVA_HOME neu co, neu khong dung javac/java trong PATH
if [ -n "${JAVA_HOME:-}" ]; then
  JAVAC="$JAVA_HOME/bin/javac"
  JAVA="$JAVA_HOME/bin/java"
else
  JAVAC="javac"
  JAVA="java"
fi

PATTERNS=(factory_method strategy visitor decorator iterator observer proxy flyweight)
if [ $# -gt 0 ]; then
  PATTERNS=("$@")
fi

mkdir -p build out outputs

echo "== Compile"
"$JAVAC" -encoding UTF-8 -d build $(find src -name "*.java") || exit 1

for p in "${PATTERNS[@]}"; do
  main="refactoring_guru.$p.example.Demo"
  result="outputs/$p.txt"
  echo "== Run $p"
  {
    echo "\$ java $main"
    echo
  } > "$result"

  case "$p" in
    strategy|iterator)
      # Demo doc du lieu tu ban phim -> lay input mau trong inputs/
      # Moi lop tao BufferedReader rieng tren System.in, nen phai dua tung dong
      # mot (co do tre) giong nhu go tay, tranh reader dau tien doc het input.
      echo "(input: inputs/$p.txt)" >> "$result"
      echo >> "$result"
      while IFS= read -r line; do
        sleep 0.5
        printf '%s\n' "$line"
      done < "inputs/$p.txt" | "$JAVA" -cp build "$main" >> "$result" 2>&1
      ;;
    flyweight)
      # Demo mo cua so Swing ve 1.000.000 cay, dong lai sau vai giay
      "$JAVA" -cp build "$main" >> "$result" 2>&1 &
      pid=$!
      sleep 5
      kill "$pid" 2>/dev/null
      wait "$pid" 2>/dev/null
      ;;
    *)
      "$JAVA" -cp build "$main" >> "$result" 2>&1
      ;;
  esac

  cat "$result"
  echo
done

# File do Decorator ghi ra (du lieu da nen + ma hoa)
if [ -f out/OutputDemo.txt ]; then
  cp out/OutputDemo.txt outputs/decorator_file_content.txt
fi

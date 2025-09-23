#!/usr/bin/env bash
set -u -o pipefail

# --- поиск бинарника DO ---
find_app() {
  for p in "./data-samples/DO" "./code-samples/DO" "./DO"; do
    [[ -x "$p" ]] && { echo "$p"; return; }
  done
  local f
  f=$(find . -maxdepth 3 -type f -name DO -perm -u=x -print -quit || true)
  [[ -n "${f:-}" ]] && { echo "$f"; return; }
  echo "ERROR: DO binary not found" >&2
  exit 1
}

APP="$(find_app)"
echo "[INFO] Using APP: $APP"

pass=0
fail=0

run_test() {
  local desc="$1"
  local expected="$2"   # ожидание уже с \n
  shift 2

  local output
  if (( $# == 0 )); then
    output="$("$APP" 2>&1 || true)"
  else
    output="$("$APP" "$@" 2>&1 || true)"
  fi

  if [[ "$output" == "$expected" ]]; then
    echo "[ OK ] $desc"
    ((pass++))
  else
    echo "[FAIL] $desc"
    printf '  expected: %q\n' "$expected"
    printf '  got:      %q\n' "$output"
    ((fail++))
  fi
}

run_test "Case 1" $'Learning to Linux'                     1
run_test "Case 2" $'Learning to work with Network'         2
run_test "Case 3" $'Learning to Monitoring'                3
run_test "Case 4" $'Learning to extra Monitoring'          4
run_test "Case 5" $'Learning to Docker'                    5
run_test "Case 6" $'Learning to CI/CD'                     6
run_test "Bad number" $'Bad number!'                       7
run_test "No args"   $'Bad number of arguments!'

echo
echo "Passed: $pass, Failed: $fail"
(( fail == 0 )) || exit 1


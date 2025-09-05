#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

hyprctl devices | awk '
  $1 == "Keyboards:" { in_kb=1; next }
  in_kb && NF == 0 { in_kb=0 }
  in_kb {
    if ($1 == "Keyboard" && $2 == "at") {
      dev = ""
    }
    else if (match($0, /^[ \t]+[a-z0-9\-]+$/, m)) {
      dev = m[0]
    }
    else if ($1 == "main:" && $2 == "yes") {
      gsub(/^[ \t]+/, "", dev)
      print dev
      exit
    }
  }
'
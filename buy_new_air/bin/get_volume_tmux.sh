#!/bin/zsh

if sound_info=$(osascript -e 'get volume settings') ; then
  if [ "$(echo $sound_info | awk '{print $8}')" = "muted:false" ]; then
    sound_volume=$(expr $(echo $sound_info | awk '{print $2}' | sed "s/[^0-9]//g") / 6 )
    str=""
    for ((i=0; i < $sound_volume; i++ )); do
      str="${str}■"
    done
    for ((i=$sound_volume; i < 16; i++ )); do
      str="${str} "
    done
    sound="#[fg=colour255,bold][$str]#[default]"
  else
    sound="#[fg=colour255,bold][      mute      ]#[default]"
  fi
  # 連続したスペースをechoで出力させるには、変数自体を""で囲わないといけない
  echo "$sound"
fi

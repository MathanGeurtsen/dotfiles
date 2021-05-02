#!/usr/bin/env zsh
function rcd {
  # ranger cd
  # adapted from the ranger github 
  tempfile=$(mktemp -t tmp.XXXXXX)
  ranger --choosedir="$tempfile" "$(echo "$(pwd)")"
  if [ "(cat -- "$tempfile")" != "(echo -n `pwd`)" ] 
     {
       cd "$(cat "$tempfile")"
     }
}

function virustotal {
  firefox  https://www.virustotal.com/gui/file/$(md5sum $argv | awk '{print $1}')
}

function reCmake {
  echo "creating build dir"
  rm -rf ./build/ &&
  mkdir ./build &&
  pushd ./build &&
  echo "running cmake..." &&
  cmake -DCMAKE_BUILD_TYPE="Debug" .. T &&
  echo "running make..." &&
  make -j4 T ;
  popd;
  echo "done";
}

function cCommands {
  	cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
	if [  -e compile_commands.json ]; then rm -r compile_commands.json;	fi
	ln -s Debug/compile_commands.json .
}

function emc {
  if [ $# -eq 1 ]
  then 
    emacsclient -n -q -c -a "emacs" $1 &
  else
    emacsclient -n -q -c -a "emacs" &
  fi
  
  if jobs | grep -q 'emacs'; then disown emacs; fi
}

function pyve {
  if [  -e venv/ ]
  then 
    echo 'activating on . '
    . venv/bin/activate
  elif [  -e ../venv/ ]
  then 
    echo 'activating on .. '
    . ../venv/bin/activate
  elif [  -e ../../venv/ ]
  then 
    echo 'activating on ../.. '
    . ../../venv/bin/activate
  else 
    echo "no venv found, searched three levels up"
  fi
}

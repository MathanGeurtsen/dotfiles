
pibox() {
  if (ssh -i ~/.ssh/testbox2 -o ConnectTimeout=3 -p 8022 mathan@192.168.0.10 hostname | grep -q "raspberrypi"); then
    echo running ssh session locally
    ssh -i ~/.ssh/testbox2 -p 8022 mathan@192.168.0.10 $@
  elif (ssh -i ~/.ssh/testbox2  -o ConnectTimeout=3 -p 8022 mathan@happy.mathangeurtsen.nl hostname | grep -q "raspberrypi"); then
    echo running ssh session over internet
    ssh -i ~/.ssh/testbox2 -p 8022 mathan@happy.mathangeurtsen.nl $@
  elif (ssh -i ~/.ssh/testbox2 -o ConnectTimeout=3 -p 8022 mathan@10.8.0.1 hostname | grep -q "raspberrypi"); then
    echo running ssh session over vpn
    ssh -i ~/.ssh/testbox2 -p 8022 mathan@10.8.0.1 $@
  fi
}

pi_status (){
  if ! (hostname | grep -q "raspberrypi"); then
    echo "only run on pi"
    return 1
  fi
  pihole status

  sudo wg show
  res=0
  if (curl  localhost:80 2> /dev/null  | grep -q "html></html>"); then 
    echo "nginx up"; 
  else
    echo "nginx down"; 
    res=1
  fi

  if (sudo ufw status | head -n1 | grep -q "Status: active"); then 
    echo "ufw up"; 
  else
    echo "ufw down"; 
    res=1
  fi

  return $res
}

pi_restart_services() {
  if ! (hostname | grep -q "raspberrypi"); then
    echo "only run on pi"
    return 1
  fi

  sudo systemctl enable --now ufw
  sudo ufw -f enable
  sudo systemctl enable --now nginx
  sudo systemctl restart nginx
  sudo systemctl enable --now ssh.service
  sudo systemctl restart ssh.service

  wg-quick down wg1
  sleep 5
  wg-quick up wg1

  pihole enable
  pihole restartdns
  pi_status
}

client_pi_status (){
  # run on client

  # wifi/dns _frequently_ cause issues
  if [ "$1" = "flush" ]; then
    sudo systemctl restart systemd-resolved.service
    nmcli radio wifi off; nmcli radio wifi on 
    sleep 8
  fi
  res=0
  if (dig +short vpn.pibox.app | grep -q "10.8.0.1"); then
    echo "dns hit for vpn.pibox.app";
  else
    echo "can't resolve vpn.pibox.app";
    res=1
  fi

  if (dig +short local.pibox.app | grep -q "192.168.0.10"); then
    echo "dns hit for local.pibox.app";
  else
    echo "can't resolve local.pibox.app";
    res=1
  fi

  if (wget --tries=2 --connect-timeout=3 --output-document=/tmp/wget-out vpn.pibox.app 2> /dev/null >/dev/null && grep -q '<!DOCTYPE html></html>' /tmp/wget-out); then
    echo "vpn.pibox.app up";
  else
    echo "vpn.pibox.app down, did you connect to vpn?";
    res=1
  fi
  if (wget --tries=2 --connect-timeout=3  --output-document=/tmp/wget-out local.pibox.app 2> /dev/null >/dev/null && grep -q '<!DOCTYPE html></html>' /tmp/wget-out); then
    echo "local.pibox.app up";
  else
    echo "local.pibox.app down, are you on local network?";
    res=1
  fi
  return $res
}

main() {
  func=$1
  if [ -z "$func" ]; then
    return 0
  elif [ "$func" = "pibox" ]; then
    pibox
  elif [ "$func" = "pi_status" ]; then
    pi_status
  elif [ "$func" = "pi_restart_services" ]; then
    pi_restart_services
  elif [ "$func" = "client_pi_status" ]; then
    client_pi_status
  else 
    echo "argument '$1' not recognized"
    return 1
  fi
}

main "$@"

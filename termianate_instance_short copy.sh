#!/bin/bash
if [ $(docker ps --format '{{.State}}' | grep -c "running")  -gt 0 ]; then
   exit 0
fi
if [ $(awk '{print $1}' /proc/uptime | cut -d' ' -f1 | cut -d'.' -f1) -ge 7200 ]; then
  sudo shutdown -h now
fi



script:
echo '#!/bin/bash' | sudo tee usr/local/bin/check_container.sh
echo 'if [ $(docker ps --format "{{.State}}" | grep -c "running") -gt 0 ]; then' | sudo tee -a usr/local/bin/check_container.sh
echo '  exit 0' | sudo tee -a usr/local/bin/check_container.sh
echo 'fi' | sudo tee -a usr/local/bin/check_container.sh
echo 'if [ $(awk '{print $1}' /proc/uptime | cut -d' ' -f1 | cut -d'.' -f1) -ge 7200 ]; then' | sudo tee -a usr/local/bin/check_container.sh
echo '  sudo shutdown -h now' | sudo tee -a usr/local/bin/check_container.sh
echo 'fi' | sudo tee -a usr/local/bin/check_container.sh
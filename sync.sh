#!/bin/bash
trap 'cp /xmly-speed-docker/sync.sh /sync' Exit
git clone --depth=1 https://github.com/Darkatse/xmly-speed-docker.git /xmly-speed-docker_tmp
[ -d /xmly-speed-docker_tmp ] && {
  rm -rf /xmly-speed-docker
  mv /xmly-speed-docker_tmp /xmly-speed-docker
}
git clone --depth=1 https://github.com/Zero-S1/xmly_speed.git /xmly_speed_tmp
[ -d /xmly_speed_tmp ] && {
  rm -rf /xmly_speed
  mv /xmly_speed_tmp /xmly_speed
}
cd /xmly_speed || exit 1
pip3 install --no-cache-dir -r requirements.txt || exit 1
cp /crontab.list /crontab.list.old
echo "55 */3 * * * bash /sync 1>/proc/1/fd/1 2>/proc/1/fd/2" > /crontab.list
echo "*/30 * * * * bash -c ' exec 1<>/proc/1/fd/1; exec 2<>/proc/1/fd/2; set -o allexport; source /all; source /env; cd /xmly_speed; python3 xmly_speed.py '" >> /crontab.list
crontab -r
crontab /crontab.list || {
  cp /crontab.list.old /crontab.list
  crontab /crontab.list
}
crontab -l
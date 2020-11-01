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
cd /scripts || exit 1
pip install --no-cache-dir -r requirements.txt || exit 1
cp /crontab.list /crontab.list.old
echo "55 */3 * * * bash /sync 1>/proc/1/fd/1 2>/proc/1/fd/2" > /crontab.list
for file in $(find /xmly_speed/.github/workflows -type f);do
  cat $file | grep -q 'cron:' && {
    cat $file | grep -q 'python3 xmly_.*\.py' && {
      a=$(cat $file | sed -En "s/^.*cron: '(.*)'.*$/\1/p")
      b=$(cat $file | sed -En 's|^.*python3 (xmly_.*\.py)$|python3 /xmly_speed/\1|p')
      name=$(cat $file | sed -En "s|^.*name: . run (.*)|\1|p" | sed "s/'//g")
      echo $file
      script="\"
        exec 1<>/proc/1/fd/1;
        exec 2<>/proc/1/fd/2;
        set -o allexport;
        source /all;
        source /env;
        cd /scripts;
        $b | sed 's/^/$name/';
      \""
      script="$(echo ${script})"
      echo "$a" bash -c "$script" >> /crontab.list
    }
  }
done
crontab -r
crontab /crontab.list || {
  cp /crontab.list.old /crontab.list
  crontab /crontab.list
}
crontab -l
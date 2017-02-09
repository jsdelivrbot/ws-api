if [ "$#" -ne 1 ]; then
  echo "1 parameters required"
  echo "export.sh [name]"
  exit
fi

api_dir=api
dev_dir=$1
prod_dir=/var/www/PROD/${1}/api
main_file=$1-api.js
path=pwd


wsCopy() {
  if [ -f ${api_dir}/$1 ] || [ -d ${api_dir}/$1 ]; then
    cp -r ${api_dir}/$1 ${prod_dir}
  fi
  if [ -f ${dev_dir}/$1 ] || [ -d ${dev_dir}/$1 ]; then
    cp -r ${dev_dir}/$1 ${prod_dir}
  fi
}

wsReplace() {
  sed -i "s|../api/||g" $prod_dir/*.js
  sed -i "s|../api/||g" $prod_dir/**/*.js
}

echo "Exporting api module ${1}"
mkdir -p $prod_dir
rm -rf $prod_dir
mkdir -p $prod_dir
wsCopy lib
wsCopy views
wsCopy static
wsCopy docs
wsCopy data
wsCopy endpoints
wsCopy main.js
wsCopy config.json
wsCopy router.js
wsCopy $main_file
wsReplace

echo 'Creating relaod script'
reload_file=/var/www/BASH/reload/app/$(echo $main_file | sed s/.js/.sh/g)
reload_args="name=$(echo $main_file | sed s/.js//g)\npath=/PROD/$1/api"
reload_cmd='sh reload.sh $path $name'
reload_text="#!/bin/bash\n# Auto generated script\n\n$reload_args\n$reload_cmd"
echo $reload_text > $reload_file
echo "Creating relaod script $reload_file"
cd /var/www/BASH/reload
sh $reload_file

echo "Done exporting API $1"

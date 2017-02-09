if [ "$#" -ne 2 ]; then
  echo "2 parameters required"
  echo "create.sh [name] [port]"
  exit
fi

root_dir=api/
lib_path=${root_dir}lib/common
wslib_path=/var/www/LIB/lib
main_file=$1-api.js

echo "Importing JS files"
sh ${root_dir}/import_lib.sh

if [ ! -d $1 ]; then
  cp -r ${root_dir}app $1
else
  echo "Folder $1 already exists"
fi

echo 'Generating main file with config'
cp ${root_dir}/app/app.js $1/$main_file
sed -i s/{{api}}/$1/g ./$1/*.js*
sed -i s/{{port_number}}/$2/g ./$1/*.js*


echo 'ALL DONE'
echo 'Running main file'
cd $1
node $main_file

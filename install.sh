api_dir=api
pkg_file=$api_dir/package.json
pkg=$(cat $pkg_file | jq '.devDependencies | to_entries | map(.key) | @sh')
for i in $pkg; do
  module=$(echo $i | sed s/\'//g | sed s/\"//g)
  sudo npm install $module -g
done


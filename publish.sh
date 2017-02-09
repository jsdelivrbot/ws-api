tmp_readme=''
ws package update
ws package describe --text "$(cat tmp_readme)"
rm tmp_readme
if [ -f .gitignore ]; then
  git pull
  git add --all
  git commit -m 'latest update'
  # git push
fi

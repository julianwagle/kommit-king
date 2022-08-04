#!/bin/bash

GITHUB_USERNAME=$1
FILE_PATH="$(pwd)/kommit.sh"
RUN_EVERY='*/10 * * * *'
CRONJOB="$RUN_EVERY $FILE_PATH $1"
NOW=$(date +"%Y%m%d%H%M%S")
echo $FILE_PATH
CRONTAB=$(crontab -l)
if [[ "$CRONTAB" == *"$CRONJOB"* ]]; 
then
  echo "Cronjob already exists"
else
    sudo chmod +x $FILE_PATH
    gh repo create kommit-king --private
    git init
    crontab -l > mycron
    echo "$CRONJOB">> mycron
    crontab mycron
    rm mycron
fi

sed -i '' -e '$ d' kommit.sh
sh -c "echo '# $NOW' >> kommit.sh"

git remote remove origin
git remote add origin https://github.com/$GITHUB_USERNAME/kommit-king.git
git add .
git commit -m $NOW
git branch -M main
git push -u origin main --force

# # I WILL CHANGE EVERY 10 MINUTES
# 20220804141953

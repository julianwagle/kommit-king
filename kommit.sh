#!/bin/bash

while getopts u:p: flag
do
    case "${flag}" in
        u) GITHUB_USERNAME=${OPTARG};;
        p) GITHUB_PASSWORD=${OPTARG};;
    esac
done
echo "Username: $GITHUB_USERNAME";
echo "Password: $GITHUB_PASSWORD";
GITHUB_ORIGIN="https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/$GITHUB_USERNAME/kommit-king.git"

SCRIPT_DIR=$( dirname -- "$( readlink -f -- "$0"; )"; )
FILE_PATH="$SCRIPT_DIR/kommit.sh"
RUN_EVERY='*/1 * * * *'
CRONJOB="$RUN_EVERY $FILE_PATH -u $GITHUB_USERNAME -p $GITHUB_PASSWORD"
NOW=$(date +"%Y%m%d%H%M%S")
echo $FILE_PATH
cd $SCRIPT_DIR
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
git remote add origin "$GITHUB_ORIGIN"
# git remote add origin http://github.com/$GITHUB_USERNAME/kommit-king.git
git add .
git commit -m $NOW
git branch -M main
git push -u origin main --force

####################################################
####################################################
####################################################
# # # TIME BELOW  WILL CHANGE EVERY 10 MINUTES # # #
####################################################
####################################################
####################################################
# 20220804170607

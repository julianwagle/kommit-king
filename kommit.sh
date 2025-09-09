#!/bin/bash

# # Grab input variables
while getopts u:e:t: flag
do
    case "${flag}" in
        u) GITHUB_USERNAME=${OPTARG};;
        e) GITHUB_EMAIL=${OPTARG};;
        t) GITHUB_TOKEN=${OPTARG};;
    esac
done

echo "Github Username: $GITHUB_USERNAME"
echo "Github Email: $GITHUB_EMAIL"
echo "Github Token: $GITHUB_TOKEN"

git config --global user.email ${GITHUB_EMAIL}
git config --global user.name ${GITHUB_USERNAME}

# # Set variables for the script
GITHUB_ORIGIN="https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_USERNAME}/kommit-king.git"
SCRIPT_DIR=$( dirname -- "$( readlink -f -- "$0"; )"; )
FILE_PATH="$SCRIPT_DIR/kommit.sh"
RUN_EVERY='*/10 * * * *'
CRONJOB="$RUN_EVERY $FILE_PATH -u ${GITHUB_USERNAME} -t ${GITHUB_TOKEN}"
NOW=$(date +"%Y%m%d%H%M%S")
CRONTAB=$(crontab -l)

cd $SCRIPT_DIR
if [[ "$CRONTAB" == *"$CRONJOB"* ]]; 
then
  echo "Doing nothing (:"
else
    # # Cron has not been set. First run
    ##### ##### ##### #####  #####  #####
    # # Grant permissions to the script
    sudo chmod +x $FILE_PATH
    # Create the privatre repo
    gh repo create kommit-king --private
    git init
    # # Add cronjob to crontab
    crontab -l > mycron
    echo "$CRONJOB">> mycron
    crontab mycron
    rm mycron
fi


# # Delete the line with the time
sed -i '' -e '$ d' kommit.sh
# # Add the current time to the bottom
sh -c "echo '# $NOW' >> kommit.sh"

# # Just incase a seperate origin was set
git remote remove origin
git remote add origin "${GITHUB_ORIGIN}"

# # Add new changes & commit them & push them
git add .
git commit -m $NOW
git branch -M main
git push -u origin main --force


# 20220927203000
# 20250909113001

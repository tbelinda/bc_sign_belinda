#!/bin/bash

INFO_COLOR="\033[36;1m"
DANGER_COLOR="\033[31;1m"
NO_COLOR="\033[0m"


display_msg() {
    if [ "$2" = "danger" ]; then
        echo -e "${DANGER_COLOR}$1${NO_COLOR}"
    else
        echo -e "${INFO_COLOR}$1${NO_COLOR}"
    fi
}


create_boilerplate() {
    local main_folder
    main_folder=bc_sign_"$1"
    mkdir -p "$main_folder"/bash_scripts/utils
    cd "$main_folder" || exit
    git init 
    github_username=$(git config --global user.name)
    git remote add origin git@github.com:"$github_username"/bc_sign_"$1".git
    touch .gitignore
    {
        echo "node_modules/"
        echo ".DS_Store"
        echo ".env"

    } >> .gitignore
    cp ../boilerplate.sh ./"$1"_boilerplate.sh
    git add .
    git commit -m feat/first-commit
    git branch -M master
    git push origin master
    git checkout -b dev
    git push origin dev
}


create_boilerplate "$1"
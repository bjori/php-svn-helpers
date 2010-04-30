#!/bin/bash
GIT_ROOT_REPOSITORY="git://github.com/php"
SVN_ROOT_REPOSITORY="http://svn.php.net/repository"
GIT_REPOSITORY="php-src.git"
SVN_REPOSITORY="php/php-src/"


usage() {
    cat <<EOF
$0 <directory> <git-repository-name> <svn-repository-name>

Checkout a module from svn.php.net via Github and reinitialize git-svn.
Run this script to get a valid git-svn repository that can be used to commit
back to svn.php.net.
EOF
}

if test $# -eq 3
then
  GIT_REPOSITORY=$2
  SVN_REPOSITORY=$3
elif test $# -eq 2
then
    GIT_REPOSITORY=$2
elif test $# -ne 1
then
    usage;
    exit 255;
fi


DIR=$1

echo "Repository: $GIT_REPOSITORY"
echo "Directroy:  $DIR"
echo "Initialize..."

(echo "mkdir $DIR && cd $DIR && git init &&git remote add origin $GIT_ROOT_REPOSITORY/$GIT_REPOSITORY && git config remote.origin.fetch 'refs/remotes/*:refs/remotes/*' && git fetch && git checkout -b master trunk && git svn init -s $SVN_ROOT_REPOSITORY/$SVN_REPOSITORY && git svn rebase")


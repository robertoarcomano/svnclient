#!/bin/bash

SVN_REPOS=/tmp/svnclient
MY_PROJECT=myproject
MY_REPO=myrepo
SVN_MY_REPO=$SVN_REPOS"/$MY_REPO"
SVN_MY_PROJECT=$SVN_MY_REPO"/$MY_PROJECT"
SVN_MY_PROJECT_URL=file://$SVN_MY_PROJECT

# 0. Delete any previous repo and local project
rm -rf $SVN_REPOS
rm -rf $MY_PROJECT

# 1. Create main svn directory
mkdir $SVN_REPOS

# 2. Create a new repo
svnadmin create $SVN_MY_REPO

# 3. Create a trunk
svn mkdir $SVN_MY_PROJECT_URL -m "trunk creation"

# 4. Checkout locally
svn co $SVN_MY_PROJECT_URL

# 5. Enter dir
cd $MY_PROJECT || exit

# 6. Add a file to the repo
echo "test" > test

# 7. Add the new file to svn
svn add test

# 8. Commit
svn commit -m "New file test"

# 9. Update
svn update

# 10. Log
svn log

# 99. Exits dir
cd ..

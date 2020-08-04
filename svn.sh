#!/bin/bash

SVN_REPOS=/tmp/svnclient
PROJECT1=project1
PROJECT2=project2
REPO=repo
SVN_REPO=$SVN_REPOS"/$REPO"
SVN_PROJECT1=$SVN_REPO"/$PROJECT1"
SVN_PROJECT2=$SVN_REPO"/$PROJECT2"
SVN_ALL_URL=file://$SVN_REPO
SVN_LOCAL_REPO=repo
SVN_PROJECT1_URL=file://$SVN_PROJECT1
SVN_PROJECT2_URL=file://$SVN_PROJECT2

# 0. Delete any previous repo and local project
rm -rf $SVN_REPOS $PROJECT1 $PROJECT2 $SVN_LOCAL_REPO

# 1. Create main svn directory
mkdir $SVN_REPOS

# 2. Create a new repo
svnadmin create $SVN_REPO

# 3. Create a trunk
svn mkdir $SVN_PROJECT1_URL -m "trunk1 creation"
svn mkdir $SVN_PROJECT2_URL -m "trunk2 creation"

# 4. Checkout locally
svn co $SVN_PROJECT1_URL
svn co $SVN_PROJECT2_URL

# 5. Work on single project
# 5.1 PROJECT1
# 5.1.1 Enter dir
cd $PROJECT1 || exit
# 5.1.2. Add a file to the repo
echo "test1" > test1
# 5.1.3. Add the new file to svn
svn add test1
# 5.1.4. Commit
svn commit -m "New file test1"
# 5.1.5. Update
svn update
# 5.1.6. Log
svn log
cd ..
# 5.2 PROJECT2
# 5.2.1 Enter dir
cd $PROJECT2|| exit
# 5.2.2. Add a file to the repo
echo "test2" > test2
# 5.2.3. Add the new file to svn
svn add test2
# 5.2.4. Commit
svn commit -m "New file test2"
# 5.2.5. Update
svn update
# 5.2.6. Log
svn log

# 5.3. Exits dir
cd ..

# 5.4. Checkout the whole repo
svn co $SVN_ALL_URL

# 6. Merge Tests
# 6.1. Update file on project1 and commit it
cd $PROJECT1 || exit
sed -i -e 's/^/MANUAL COMMIT\n/' test1
svn commit -m "MANUAL COMMIT"
cd ..
# 6.2. Update file on while repo
cd repo || exit
echo
echo "BEFORE"
echo "======================="
cat $PROJECT1/test1
echo "======================="
echo "MERGED" >> $PROJECT1/test1
svn commit -m "MERGED"
svn merge $SVN_ALL_URL .
echo
echo "AFTER"
echo "======================="
cat $PROJECT1/test1
echo "======================="
cd ..

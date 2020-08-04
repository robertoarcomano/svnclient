# svnclient
Tutorial for svn

## Script <a href=svn.sh>svn.sh</a>
```
#!/bin/bash

SVN_REPOS=/tmp/svnclient
PROJECT1=myproject1
PROJECT2=myproject2
REPO=repo
SVN_REPO=$SVN_REPOS"/$REPO"
SVN_PROJECT1=$SVN_REPO"/$PROJECT1"
SVN_PROJECT2=$SVN_REPO"/$PROJECT2"
SVN_ALL_URL=file://$SVN_REPO
SVN_PROJECT1_URL=file://$SVN_PROJECT1
SVN_PROJECT2_URL=file://$SVN_PROJECT2

# 0. Delete any previous repo and local project
rm -rf $SVN_REPOS $PROJECT1 $PROJECT2

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
```
## OUTPUT
```
berto@clevo:~/IdeaProjects/svnclient$ /bin/bash /home/berto/IdeaProjects/svnclient/svn.sh
Committing transaction...
Committed revision 1.
Committing transaction...
Committed revision 2.
Checked out revision 2.
Checked out revision 2.
A         test1
Adding         test1
Transmitting file data .done
Committing transaction...
Committed revision 3.
Updating '.':
At revision 3.
------------------------------------------------------------------------
r3 | berto | 2020-08-04 21:09:01 +0100 (Tue, 04 Aug 2020) | 1 line

New file test1
------------------------------------------------------------------------
r1 | berto | 2020-08-04 21:09:01 +0100 (Tue, 04 Aug 2020) | 1 line

trunk1 creation
------------------------------------------------------------------------
A         test2
Adding         test2
Transmitting file data .done
Committing transaction...
Committed revision 4.
Updating '.':
At revision 4.
------------------------------------------------------------------------
r4 | berto | 2020-08-04 21:09:01 +0100 (Tue, 04 Aug 2020) | 1 line

New file test2
------------------------------------------------------------------------
r2 | berto | 2020-08-04 21:09:01 +0100 (Tue, 04 Aug 2020) | 1 line

trunk2 creation
------------------------------------------------------------------------
A    repo/myproject1
A    repo/myproject1/test1
A    repo/myproject2
A    repo/myproject2/test2
Checked out revision 4.
```
#!/bin/fish
# A script to go move my 'github' remote to origin and rename gitlab origin to 'gitlab'

set orig_dir (pwd)

# Go through each directory
for d in (ls -D1)
    if test ! -d $d 
        continue
    end

    cd $d
    
    if ! test -d .git
        echo "** Skipping non-git repository '$d'"
        cd $orig_dir
        echo "--------------"
        continue
    end

    echo "- Updating remotes in $d"
    # set gitlab_origin_url (git config remote.origin.url | grep gitlab.com)
    # if test "$gitlab_origin_url" != ""
    #     echo "    - Found origin with Gitlab, moving it to remote named gitlab"
    #     git remote rename origin gitlab
    # end

    set still_origin_url (git config remote.origin.url)
    set github_origin_url (git config remote.origin.url | grep github.com)
    if test "$still_origin_url" != ""
        if test "$github_origin_url" = ""
            echo "    ** An origin URL other than gitlab found ($still_origin_url), moving to backup"
            git remote rename origin origin_old
        else
            echo "    - Found origin is already setup for Github"
        end
    end

    set github_remote_url (git config remote.github.url)
    if test "$github_remote_url" != ""
        if test "$github_origin_url" = "" 
            echo "    - Found github remote, duplicating to have origin "
            git remote add origin $github_remote_url
        end
    else 
        echo "    ** No Github remote found"
    end 

    cd $orig_dir
    echo "--------------"
end

echo "Done."
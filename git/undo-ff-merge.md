So I was careless today and did a merge without thinking, resulting in a fast forward merge. Luckily there is a way to undo it:

```
$ git reflog show BRANCHNAME
$ git reset --keep BRANCHNAME@{1}
```

source: http://blog.tplus1.com/blog/2011/09/23/undo-a-fast-forward-git-merge/

There is also a configuration option to remove default ff merges:

```
git config --global merge.ff false
```

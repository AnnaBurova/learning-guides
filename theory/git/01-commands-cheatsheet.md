```text
Author: NewtCode Anna Burova
Created: 2026-10
```

# Git Commands Cheatsheet

## Basic Workflow

```sh
git status               # Show working tree status
git add -A               # (--all) Stages changes from all tracked and untracked files
git add .                # Stages changes from all tracked and untracked files in current directory
git add <filename>       # Stages single file or regex to staging area
git commit -m "Message"  # Record changes to repository with message
git diff                 # Show changes between commits, commit and working tree, etc
git diff --summary       # Summary of creations, renames and mode changes
git diff --staged        # (--cached) Compares a stash and HEAD (already committed changes)

# Save result to file:
git diff --staged > changes.patch.diff.txt       # Compare staged changes
git diff v1.0.0 v1.1.1 > changes.patch.diff.txt  # Compare two tags
```

## Stash Workflow

```sh
# Use stash when unfinished work needs to be temporarily saved.
git stash                    # Stash unstaged changes (doesn't take untracked files)
git stash -u                 # Stash all changes including untracked files
git stash push -m "Message"  # Stash with a message for easier identification
git stash list               # List all stashed changes
git stash show -p            # Show details of most recent stash
git stash pop                # Return most recent stash and remove it from stash list
git stash apply              # Return most recent stash without removing it from stash list
git stash drop               # Remove most recent stash without applying it
git stash clear              # Remove all stashes
```

## Reset and Restore

```sh
git reset                 # Unstage all files (remove from staging area)
git reset --mixed HEAD~1  # Undo last commit, keep changes unstaged (default)
git reset --soft HEAD~1   # Undo last commit, keep staged changes
git reset --hard HEAD~1   # Undo last commit and discard all files and directories
git reset <filename>      # Unstage a file (keep changes in working directory)
# Use `git reset --hard` only when local changes are intended to be lost.

git restore                      # Discard changes in working directory from last commit
git restore <filename>           # Discard local changes in a file
git restore --staged <filename>  # Unstage a file (keep changes in working directory)
```

## Date Management

```sh
git commit --date="2026-01-30 14:00:00" -m "Message"                # Set a custom date for commit
git commit --date="2026-01-30T14:00:00" -m "Message" --allow-empty  # Empty commit on custom date
git commit --date="2026-01-30T14:00:00" --amend --no-edit           # Change last commits date without changes
```

```sh
GIT_AUTHOR_DATE="2026-01-30T14:00:00" \
GIT_COMMITTER_DATE="2026-01-30T14:00:00" \
git commit --amend --no-edit --date="2026-01-30T14:00:00"
```

```sh
GIT_AUTHOR_DATE        # set actual author timestamp
GIT_COMMITTER_DATE     # set actual commiter timestamp

--amend                # rewrite last commit
--no-edit              # keep same commit message

--allow-empty          # allows committing without any file changes

--date                 # manually set commit date and author timestamp
"YYYY-MM-DDTHH:MM:SS"  # letter 'T' is required between date and time
```

## Log and History

```sh
git log --oneline                           # Compact log view
git log --oneline > history.txt             # Export log summary to a file
git log --oneline --graph --decorate --all  # Visualize branch structure and commits

git log --pretty=format:"%h %ad | %an | %s" --date=short  # Detailed custom log format
# 332902e 2026-01-30 | Anna Burova | chore(version): bump project version to 0.1.1

git log --pretty=format:"%h%nAuthor: %an%nDate: %ad%nMessage: %s%n" --date=iso
# 332902e
# Author: Anna Burova
# Date: 2026-01-30 14:00:00 +0300
# Message: chore(version): bump project version to 0.1.1

git log --pretty=format:"%h %s%n  Author date: %ad%n  Commit date: %cd" --date=iso
# 332902e chore(version): bump project version to 0.1.1
#   Author date: 2026-01-30 14:00:00 +0300
#   Commit date: 2026-01-30 14:00:00 +0300
```

```sh
git show <commit_hash>  # Show details of a specific commit
git blame <file>        # Show line-by-line history of a file
```

## File Normalization

```sh
# Use this after changing .gitattributes or line-ending rules.
git add --renormalize <filename>  # Re-apply .gitattributes rules to specific file
git add --renormalize .           # Re-apply .gitattributes rules to all files
```

## Branching

```sh
git branch                      # List local branches
git branch -a                   # List all branches

git switch -c feature/new-ui    # Create and switch to a new branch
git switch main                 # Switch to an existing branch

git checkout -b feature/new-ui  # Create and switch to a new branch
git checkout main               # Switch to an existing branch

git merge feature/new-ui        # Merge a branch into the current one
git merge origin/main           # Merge the latest changes from main into the current branch

git branch -d feature/new-ui    # Delete a branch (after merge)
git branch -D feature/new-ui    # Force delete branch
```

## Remote Management

```sh
git clone https://github.com/user/repo.git              # Clone a remote repositoryy into a new directory
git remote -v                                           # Show remotes
git remote add origin https://github.com/user/repo.git  # Add a new remote
git remote rename origin upstream                       # Rename remote
```

## Fetching and Pulling

```sh
git fetch          # Fetch new branches and updates (no merge)
git pull --rebase  # Fetch and rebase (recommended for teams)
git pull           # Merge changes directly (less clean history)
```

## Pushing Changes

```sh
git push                        # Push the current branch
git push origin feature/new-ui  # Push a specific branch
git push --force-with-lease     # Force push (wont overwrite teammates work)
git push --force                # Force push (overwrite teammates work)
```

If `push --force`,
git replaces branch on remote server with local branch, no matter what's there.

If `push --force-with-lease`,
git first checks whether remote branch still points to same commit last local fetched.
If no one else has pushed, this push proceeds (safe).
If someone else pushed new commits, Git refuses to push and gives warning.

## Rebasing and History Cleanup

Combine, edit, or delete commits before merging

```sh
# Rebase the branch with main (update history cleanly)
git fetch origin
git rebase origin/main

# Interactive rebase for cleanup
git rebase -i HEAD~5   # Edit last 5 commits
git rebase --continue  # Continue after resolving conflicts
git rebase --abort     # Abort rebase and return to original state
```

## Tags and Releases

```sh
git tag                      # List all local tags
git tag -n                   # List all local tags with annotation
git ls-remote --tags origin  # List all remote tags
```

```sh
git tag --sort=v:refname -n                   # List tags sorted by version number with annotation
git config --global tag.sort version:refname  # Set default tag sorting to version number (once per repository or globally)
```

```sh
# Create tags
git tag v1.0.0                                         # Create lightweight tag
git tag -a v1.0.0 -m "First release"                   # Create annotated tag (recommended)
git tag v1.0.0 332902e                                 # Create lightweight tag on specific commit
git tag -a v1.0.0 332902e -m "[v1.0.0] First release"  # Create annotated tag on specific commit

# Delete tags
git tag -d v1.0.0                                      # Delete local tag
```

```sh
git show v1.0.0                 # Show tag details
git push --tags                 # Push all tags to remote
git push origin --force --tags  # Force push tags (use with caution)
git push origin v1.0.0          # Push specific tag to remote
git fetch --tags                # Fetch all tags from remote
git checkout v1.0.0             # Checkout to tagged version
```

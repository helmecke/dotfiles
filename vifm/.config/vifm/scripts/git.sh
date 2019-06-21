#!/bin/sh
# vim: fdm=marker

# Icons {{{1
UNTRACKED_ICO=''
UNSTAGED_ICO=''
STAGED_ICO=''

BEHIND_ICO=''
AHEAD_ICO=''

STASH_ICO=''
TAG_ICO=''
# BOOKMARK_ICO=''

# COMMIT_ICO=''
BRANCH_ICO=''

# Branch {{{1

vcs_branch() {
	name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
	[ -n "$name" ] && echo " ${BRANCH_ICO} ${name}"
}

# Status {{{1

vcs_status() {
	# shellcheck disable=SC2039
	local res untrackedFiles unstaged staged
	# check for merge
	if ! git merge HEAD > /dev/null 2> /dev/null
	then
		echo " | merge"
		return
	fi

	# if merge is not in progress
	res=""

	# count untracked files
	untrackedFiles=$(git ls-files --others --exclude-standard 2> /dev/null)
	[ -n "$untrackedFiles"  ] && res="$res ${UNTRACKED_ICO}"

	# count ustaged changes
	unstaged=$(git ls-files --modified 2> /dev/null)
	[ -n "$unstaged" ] && res="$res ${UNSTAGED_ICO}"

	# count staged changes/files
	staged=$(git diff --staged --name-status 2> /dev/null | wc -l)
	[ "$staged" -ne 0 ] && res="$res ${STAGED_ICO}"

	echo "$res"
}

# Commits {{{1

vcs_commits() {
	# shellcheck disable=SC2039
	local branch res ahead behind

	branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
	res=""

	ahead=$(git rev-list --count "$branch@{upstream}..HEAD" 2>/dev/null)
	[ -n "$ahead" ] && [ "$ahead" -gt 0 ] && res="$res ${AHEAD_ICO} $ahead"

	behind=$(git rev-list --count "HEAD..$branch@{upstream}" 2>/dev/null)
	[ -n "$behind" ] && [ "$behind" -gt 0 ] && res="$res ${BEHIND_ICO} $behind"

	echo "$res"
}

# Tags {{{1

vcs_tag() {
	# shellcheck disable=SC2039
	local tags res

	tags=$(git describe --tags --abbrev=0 2> /dev/null)
	res=""

	for tag in $tags; do
		res="$res ${TAG_ICO} $tag "
	done

	echo "$res"
}

# Stashes {{{1

vcs_stashes() {
	# shellcheck disable=SC2039
	local stashes
	stashes=$(git stash list 2> /dev/null |wc -l)
	[ "$stashes" -gt 0 ] && echo " ${STASH_ICO} $stashes"
}

# Main {{{1

vcs_main() {
	# are we inside repo?
	if git rev-parse --show-toplevel >/dev/null 2>&1
	then
		echo "$(vcs_branch)$(vcs_status)$(vcs_commits)$(vcs_tag)$(vcs_stashes) "
	fi
}

vcs_main

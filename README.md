## github_tool
Simple github tool for daily working on add comment to issue and move card to confirmation column

### Why?

After each time you fix an issue, you usually do the following steps:

* Comment to fixed issue that you've fixed it.
* Move this issue's card to Need Confirmation column

and it should be automatically done by a command!

### Install

* Ruby has been installed on your machine already.
* Clone this repo: `$git clone https://github.com/manhdaovan/github_tool.git`
* Install dependent gem: `$gem install bundle && bundle install`
* Copy `.env.example` file to `.env`: `$cp .env.example .env`
* Fill necessary infomation into `.env` file. It's done.

### Usage

```
Usage: $ruby /path/to/gh.rb cmd issue_id1 [issue_id2 ...] [comment content]
cmd:
     comment: Comment into given issue(s)
     move:    Move given issue(s) from GH_COLUMN_SOURCE to GH_COLUMN_TARGET
     comment_and_move: Combination of comment and move commands
     info:    Get given issue(s) link(s) and title(s)
Eg:    $ruby gh.rb move 1498 1750 1321 1678 507 1645 1135
Or:    $ruby gh.rb comment 1498 1750 1321 1678 507 1645 1135 "This is a comment content"
```

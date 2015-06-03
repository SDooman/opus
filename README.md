The Opus Education Platform
============================

## Motivation

We'll use this repo for you guys to get a hang of 
working on the same codebase using Git, and to build the
staff interface.  Once we iterate on this interface, then
we'll move on to a new repo to build the full app.  This 
will give us flexibility to learn all of the tools we'll
need for effective testing, versioning, etc. and then
be able to design the app architecture around them.

Local Setup
============================

* Clone the repo

```
git clone git@github.com:SDooman/opus.git
cd ./opus
```

Git Workflow
============================

* Create a feature branch -- `git checkout -b your-feature-branch`
* Push all commits to origin/your-feature-branch at github
* When your branch meets the requirements to merge against development,
	issue a pull request -- `hub pull-request -base development`
* Once your branch is discussed & approved:
* Rebase your branch -- `git fetch origin && git rebase origin/development`
* Squash your branch -- `git rebase -i origin/development`
* Merge branch -- `git checkout development && git pull origin development && git merge your-feature-branch`
* push your branch -- `git push`

Whenever you commit changes to a branch, use the following
structure to maximize the readibility of our repo's git logs.

`git commit -a -m "[Your Initials] Intelligent commit message"`

Here's an example.  You should be able to read a commit message and
immediately know "this commit does [x]"

`git commit -a -m "[SD] Initializes REAMDE.md and xcode project"`

Tools
============================

* [hub](http://github.com/github/hub)
* [git-flow](http://github.com/nvie/gitflow)

Style, Best Practices, References
============================
* [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
* [Objective C Style Guide](https://github.com/NYTimes/objective-c-style-guide)
* [Best Practices](https://github.com/futurice/ios-good-practices)
* [SemVer](http://semver.org/)

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

```
git clone --recursive git@github.com:SDooman/opus-interface.git
cd ./opus-interface
```

Git Workflow
============================

* Create a feature branch -- `git checkout -b your-feature-branch`
* Push all commits to origin/your-feature-branch at github
* When your branch meets the requirements to merge against development branch,
 use `hub pull-request -b develop`
* Once your branch is discussed & approved:
* Rebase your branch -- `git fetch origin && git rebase origin/develop`
* Squash your branch -- `git rebase -i origin/develop`
* Merge branch -- `git checkout develop && git pull origin develop && git merge your-feature-branch`
* push your branch -- `git push`
* (Optional) Delete your branch using `git branch -d your-feature-branch && git push origin :your-feature-branch`

Whenever you commit changes to a branch, use the following
structure to maximize the readibility of our repo's git logs.

`git commit -a -m "[*x*] *y* *z*"`

*x* is your initials (ex. [SD])

*y* is one of the following present tense verbs describing the commit:
* tests - writes tests for feature's functionality
* implements - fills out stencils of methods for target functionality
* finishes - feature is tested and implemented
* stencils - creates classes and method signatures for target functionality
* fixes - fixes a bug in particular feature
* refactors - redesigns program structure to remove technical debt
* hacks - implements, but with known technial debt
* edits - reserved for changing project files without code (README.md, .gitignore)

*z* is the desired feature/group of files that implement a feature

Below is an example:

`git commit -a -m "[SD] implements audio playback "`

Tools
============================

* [hub](http://github.com/github/hub)

Style, Best Practices, References
============================
* [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
* [Objective C Style Guide](https://github.com/NYTimes/objective-c-style-guide)
* [Best Practices](https://github.com/futurice/ios-good-practices)
* [SemVer](http://semver.org/)
* [Git Branching Model](http://nvie.com/posts/a-successful-git-branching-model/)


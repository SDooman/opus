The Opus Education Platform
============================

## Motivation

Opus is a sheet music writing application, with an interface designed for new musicians to learn the early tenets of theory. The code in this repository was written by the Opus team comprised of Samuel Dooman, Peter Bowden, and Nick DeMarco during the summer of 2015, through the B-Lab Entreprenurial Accellerator at Brown University. The application is currently considered to be in beta, though it has been placed on indefinite hiatus.

Copyright (c) <2015> <Bowden, DeMarco, Dooman>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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


# How to contribute

We welcome contributions from external contributors, and this document describes
how to merge code changes. The procedure for contributing code is exactly the
same for the core development team and for external contributors:

* Maintainers do not push directly to the repository.
* Maintainers do not review their own patches.
* Approval of one or more maintainers is sufficient for trivial patches.
  Trivial patches are (typos and trivial bugfixes)
* For any patch that is not trivial, two maintainers need to sign off the patch.

Finally, we do not require any formal copyright assignment or contributor
license agreement. Any contributions intentionally sent upstream are presumed
to be offered under terms of the [MIT license](https://tldrlegal.com/license/mit-license)

## Getting Started

* Make sure you have a [GitHub account](https://github.com/signup/free).
* [Fork](https://help.github.com/articles/fork-a-repo/) the
  [bast/cmake-recipes](https://github.com/bast/cmake-recipes) repository on GitHub.
* On your local machine,
  [clone](https://help.github.com/articles/cloning-a-repository/) your fork of
  the repository.
* The Psi4 documentation has more detailed instructions for interacting with your fork which can be found
  [here](http://psicode.org/psi4manual/master/build_obtaining.html#faq-forkpsi4public).
  and [here](http://psicode.org/psi4manual/master/build_obtaining.html#faq-githubworkflow).

## Making Changes

* Add some really awesome code to your local fork.  It's usually a [good
  idea](http://blog.jasonmeridth.com/posts/do-not-issue-pull-requests-from-your-master-branch/)
  to make changes on a
  [branch](https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/)
  with the branch name relating to the feature you are going to add.
* When you are ready for others to examine and comment on your new feature,
  navigate to your fork on GitHub and open a [pull request](https://help.github.com/articles/using-pull-requests/) (PR). 
  Note that after you launch a PR from one of your fork's branches, all
  subsequent commits to that branch will be added to the open pull request
  automatically. Each commit added to the PR will be validated for mergeability,
  compilation and test suite compliance; the results of these tests will be
  visible on the PR page.
* If you're providing a new feature, you must add test cases and documentation.
* When the code is ready to go, make sure you run the full or relevant portion
  of the test suite on your local machine to check that nothing is broken.
* When you're ready to be considered for merging, check the "Ready to go"
  box on the PR page to let the maintainer team know that the changes are complete.
  The code will not be merged until this box is checked, the continuous
  integration (Travis for Linux and Mac, AppVeyor for Windows) returns checkmarks,
  and multiple core developers give "Approved" reviews.

### Conventions

- Folders for recipes are named `chapter-N/recipe-M`, where `N` is the chapter number and `M` is a number, _i.e._
  `01`, `02`, etc. In each chapter we restart the recipe counter.
- Each recipe can have more than one example subfolder. These subfolders are
  named `*example*`. Any code must reside in these subfolders.


### Updating the table of contents and generate README files

The README files that form the table of contents (main README.md, chapter READMEs and recipe READMEs
are generated from title.txt and abstract.md files.

This means that you should not modify README.md files but rather only edit title.txt and abstract.md files.

To update the README files, run `python contributing/generate-readmes.py` - this file updates READMEs in place.


### Coding style

#### Indentation

We use 2 spaces instead of 4 spaces to reduce the printed page width.
No tabs.


#### Case of commands

We use lowercase for commands, i.e.:
```cmake
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
```
and not:
```cmake
CMAKE_MINIMUM_REQUIRED(VERSION 3.5 FATAL_ERROR)
```


#### Line continuation

It is OK to put commands on one line if it improves readability, e.g.:
```cmake
list(APPEND CXX_BASIC_FLAGS "-g3" "-O1")
```

For line continuation we use the following style:
```cmake
target_compile_options(asan-example
  PUBLIC
    ${CXX_BASIC_FLAGS}
    ${_asan_flags}
  )

set(_whathaveyou
  item1
  item2
  item3
  )
```


#### Variable names

Start an internal variable (i.e. one that is not exposed to the user) with an
underscore:
```cmake
set(PUBLIC_VARIABLE "this one is exposed")

set(_temp "this one is internal")
```

# Additional Resources

* [General GitHub documentation](https://help.github.com/)
* [PR best practices](http://codeinthehole.com/writing/pull-requests-and-other-good-practices-for-teams-using-github/)
* [A guide to contributing to software packages](http://www.contribution-guide.org)
* [Thinkful PR example](http://www.thinkful.com/learn/github-pull-request-tutorial/#Time-to-Submit-Your-First-PR)

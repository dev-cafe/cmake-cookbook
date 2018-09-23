# How to contribute

We welcome contributions from external contributors.
This document describes the contribution process: from proposing a change to
getting it merged into CMake Cookbook.
Our contribution guide is based on [Psi4 contribution guide].

## Getting Started

* Make sure you have a [GitHub account].
* [Fork] the [dev-cafe/cmake-cookbook] repository on GitHub.
* On your local machine, [clone] your fork of the CMake Cookbook repository.

## Making Changes

* Add some really awesome code to your local fork. It's usually a [good idea] to
  make changes on a [branch] with the branch name relating to the feature you
  are going to add. A style guide is available in the [STYLE_GUIDE.md file].
* **Signoff** your patches by using the [`git commit -s` command] to commit them.
  This will show the CMake Cookbook team that you have read and agreed to the
  [Developer Certificate of Origin] (DCO).
* When you are ready for others to examine and comment on your new feature,
  navigate to your fork of CMake Cookbook on GitHub and open a [pull request] (PR)
  __towards the `master` branch__.
  Note that after you launch a PR from one of your fork's branches, all
  subsequent commits to that branch will be added to the open pull request
  automatically.
  Each commit added to the PR will be validated for mergeability, compilation
  and test suite compliance; the results of these tests will be visible on the
  PR page.
* The title of your pull request should be marked with `[WIP]` if it’s a work
  in progress. Feel free to use as many labels as you think necessary!
* Update the [`CHANGELOG.md`] file. We follow the conventions and recommendations detailed at
  [keepachangelog.com]
* When the code is ready to go, make sure you run the full test suite on your
  local machine to check that nothing is broken. Read [here for further details on testing]
* When you're ready to be considered for merging, check the "Ready to go" box
  on the PR page to let the CMake Cookbook team know that the changes are complete.
  The code will not be merged until this box is checked, the continuous
  integration services return passing checkmarks, and maintainers give "Approved" reviews.

## Licensing

* We do not require any formal copyright assignment or contributor license agreement.
* **Any contributions intentionally sent upstream are presumed to be offered under the terms of the OSI-approved [MIT License].**
* You should read the [DCO] and certify that you agree to it by **signing off** your patch using the [`git commit -s` command].
  Note that signing off and GPG-signing a commit are not the same thing and **we do not require** [GPG-signing] your commits.
  We use a [DCO bot] to ensure that submitted patches are signed off. The bot
  will block merging and suggest actions to resolve the block.

# Additional Resources

* [General GitHub documentation](https://help.github.com/)
* [PR best practices](http://codeinthehole.com/writing/pull-requests-and-other-good-practices-for-teams-using-github/)
* [A guide to contributing to software packages](http://www.contribution-guide.org)
* [Thinkful PR example](http://www.thinkful.com/learn/github-pull-request-tutorial/#Time-to-Submit-Your-First-PR)
* [Developer Certificate of Origin versus Contributor License Agreements](https://julien.ponge.org/blog/developer-certificate-of-origin-versus-contributor-license-agreements/)


[Psi4 contribution guide]: https://github.com/psi4/psi4/blob/master/.github/CONTRIBUTING.md
[GitHub account]: https://github.com/signup/free
[Fork]: https://help.github.com/articles/fork-a-repo/
[dev-cafe/cmake-cookbook]: https://github.com/dev-cafe/cmake-cookbook
[clone]: https://help.github.com/articles/cloning-a-repository/
[good idea]: http://blog.jasonmeridth.com/posts/do-not-issue-pull-requests-from-your-master-branch/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/
[STYLE_GUIDE.md file]: ../STYLE_GUIDE.md
[`git commit -s` command]: https://git-scm.com/docs/git-commit#git-commit---signoff
[Developer Certificate of Origin]: https://developercertificate.org/
[pull request]: https://help.github.com/articles/using-pull-requests/
[`CHANGELOG.md`]: ../CHANGELOG.md
[keepachangelog.com]: https://keepachangelog.com/en/1.0.0/
[here for further details on testing]: ../testing/README.md
[MIT License]: ../LICENSE
[DCO]: https://developercertificate.org/
[GPG-signing]: https://git-scm.com/docs/git-commit#git-commit---gpg-signltkeyidgt
[DCO bot]: https://github.com/probot/dco

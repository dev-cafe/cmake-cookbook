

# Chapter 15: Porting a Project to CMake

The final chapter of the cookbook demonstrates step-by-step how to port a
non-trivial project to CMake.

The example project is the source code behind the popular editor Vim
(https://www.vim.org) in which we port the configuration and compilation from
Autotools to CMake.

Here we link to the diff between "before" and "after":
https://github.com/dev-cafe/vim/compare/b476cb7...cmake-support

However, this diff probably only makes sense in combination with the textbook
in contrast to all other recipes which can be reused also independently.

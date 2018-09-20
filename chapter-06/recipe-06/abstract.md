The Git hash of a commit uniquely determines the state of the source code in a
Git repository. Therefore, to uniquely brand the executable, we will burn the
Git hash into the executable by recording the hash string in a header file that
can be included and used at the right place in the code.

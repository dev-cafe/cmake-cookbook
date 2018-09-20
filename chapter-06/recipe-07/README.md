# Recording the Git hash at build time

In [Recipe 6, *Recording the Git hash at configure time*](../recipe-06),
we recorded the state of the code repository
(Git hash) at configure time. In this recipe, we wish to go a step further and
demonstrate how to record the Git hash (or, generally, perform other actions)
at build time, to make sure that these actions are run every time we build the
code, since we may configure only once but build several times.


- [cxx-example](cxx-example/)

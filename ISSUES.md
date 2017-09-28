
## Flags set on a Fortran target are not inherited by other targets

See for example recipe-0010. If I set a flag on the library as PUBLIC,
the executable consuming the library will not inherit the same flag.

## Fortran standard detection/enforcing

## Fortran compile features are missing

## Finding Python modules doesn't work as one would expect

I think it's legitimate to expect that finding Python modules would
accept:
- A version number
- EXACT
- QUIET
- REQUIRED
This is currently not possible and writing a good find for Python modules
requires some more thought.

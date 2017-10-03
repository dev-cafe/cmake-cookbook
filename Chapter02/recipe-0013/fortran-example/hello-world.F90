program hello

   implicit none

#ifdef IS_Intel_COMPILER
   print *, 'Hello Intel compiler!'
#elif IS_GNU_COMPILER
   print *, 'Hello GNU compiler!'
#elif IS_PGI_COMPILER
   print *, 'Hello PGI compiler!'
#elif IS_XL_COMPILER
   print *, 'Hello XL compiler!'
#else
   print *, 'Hello unknown compiler!'
#endif

end program

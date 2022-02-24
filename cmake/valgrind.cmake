if(FWE_VALGRIND)
  find_program(VALGRIND_COMMAND valgrind)
  if(NOT VALGRIND_COMMAND)
    message(FATAL_ERROR "valgrind is not installed")
  endif()
endif()

function(add_valgrind_test BINARY)
  if(FWE_VALGRIND)
    set(VALGRIND_OPTIONS --error-exitcode=1 --leak-check=full --show-leak-kinds=all --gen-suppressions=all)
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/test/valgrind.supp)
      set(VALGRIND_OPTIONS --suppressions=${CMAKE_CURRENT_SOURCE_DIR}/test/valgrind.supp ${VALGRIND_OPTIONS})
    endif()
    add_test(NAME valgrind_${BINARY}
      COMMAND ${VALGRIND_COMMAND} ${VALGRIND_OPTIONS} ./${BINARY} ${ARGN})
  endif()
endfunction()
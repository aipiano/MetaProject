set(TARGET libone)

set(${TARGET}_SRC 
    ${CMAKE_CURRENT_SOURCE_DIR}/src/libone.cpp
    )

set(${TARGET}_HDR
    ${CMAKE_CURRENT_SOURCE_DIR}/include/libone/libone.hpp
    )

set(${TARGET}_TEST
    ${CMAKE_CURRENT_SOURCE_DIR}/test/libone_test.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/test/libone_test2.cpp
    )

create_library(${TARGET} STATIC)
if(BUILD_TEST)
    create_test(${TARGET})
endif()

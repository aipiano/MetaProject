set(TARGET appone)

set(${TARGET}_SRC 
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
    )

set(${TARGET}_HDR
    )

set(${TARGET}_LIB
    libone)

create_app(${TARGET})

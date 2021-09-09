macro(create_app TARGET)
    foreach(extra_lib ${${TARGET}_EXTRA_LIB})
        find_package(${extra_lib} REQUIRED)
    endforeach()

    add_executable(${TARGET} ${${TARGET}_SRC} ${${TARGET}_HDR})
    target_compile_features(${TARGET} PRIVATE cxx_std_14)

    target_include_directories(${TARGET} PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>)

    target_link_libraries(${TARGET} PRIVATE 
        ${${TARGET}_LIB} 
        ${${TARGET}_EXTRA_LIB}
        dl rt pthread anl)

    install(TARGETS ${TARGET}
        EXPORT ${TARGET}
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin)
endmacro()
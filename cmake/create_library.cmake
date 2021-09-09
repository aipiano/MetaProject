macro(create_library TARGET TYPE)
    foreach(extra_lib ${${TARGET}_EXTRA_LIB})
        find_package(${extra_lib} REQUIRED)
    endforeach()

    add_library(${TARGET} ${TYPE} ${${TARGET}_SRC} ${${TARGET}_HDR})
    target_compile_features(${TARGET} PUBLIC cxx_std_14)

    target_include_directories(${TARGET} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>)

    target_link_libraries(${TARGET} PUBLIC 
        ${${TARGET}_LIB} 
        ${${TARGET}_EXTRA_LIB}
        dl rt pthread anl)

    # Configuration
    set(config_install_dir "lib/cmake/${TARGET}")
    set(include_install_dir "include/${TARGET}")
    set(version_config "${CMAKE_CURRENT_BINARY_DIR}/${TARGET}ConfigVersion.cmake")
    set(target_config "${CMAKE_CURRENT_BINARY_DIR}/${TARGET}Config.cmake")
    set(targets_export_name "${TARGET}Targets")
    set(namespace "")

    # Configure '<TARGET>ConfigVersion.cmake'
    # Note: PROJECT_VERSION is used as a VERSION
    write_basic_package_version_file(
        "${version_config}" COMPATIBILITY SameMajorVersion)

    # Configure '<TARGET>Config.cmake'
    # Use variables:
    #   * targets_export_name
    #   * TARGET
    configure_package_config_file(
        "cmake/Config.cmake.in"
        "${target_config}"
        INSTALL_DESTINATION "${config_install_dir}")

    # Export '<TARGET>Targets.cmake' to build dir (to find package in build dir without install)
    export(TARGETS ${TARGET} FILE "${CMAKE_CURRENT_BINARY_DIR}/${targets_export_name}.cmake")

    # install target
    install(TARGETS ${TARGET}
        EXPORT "${targets_export_name}"
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION "${include_install_dir}")

    # install configs
    install(FILES "${target_config}" "${version_config}"
        DESTINATION "${config_install_dir}")

    install(EXPORT "${targets_export_name}"
        NAMESPACE "${namespace}"
        DESTINATION "${config_install_dir}")

    # install headers
    install(FILES ${${TARGET}_HDR} DESTINATION "${include_install_dir}")
endmacro()
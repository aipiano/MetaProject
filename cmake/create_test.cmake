macro(create_test TARGET)
    enable_testing()

    foreach(single_item ${${TARGET}_TEST})
        # Get source file name (without extention)
        get_filename_component(single_src ${single_item} NAME_WE)

        set(TEST_CASE ${TARGET}_${single_src})
        set(${TEST_CASE}_SRC ${single_item})

        add_executable(${TEST_CASE} ${${TEST_CASE}_SRC})
        target_compile_features(${TEST_CASE} PRIVATE cxx_std_14)

        target_include_directories(${TEST_CASE} PRIVATE
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<BUILD_INTERFACE:${gtest_SOURCE_DIR}/include>
            $<BUILD_INTERFACE:${gtest_SOURCE_DIR}>)

        target_link_libraries(${TEST_CASE} PRIVATE ${TARGET} gtest gtest_main)

        add_test(${TEST_CASE} ${TEST_CASE})
    endforeach()
endmacro()
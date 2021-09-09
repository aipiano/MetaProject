cmake_minimum_required(VERSION 3.10)

project(mega_project VERSION 1.0 LANGUAGES CXX)

option(BUILD_TEST "Enable building all tests." OFF)

include(cmake/create_library.cmake)
include(cmake/create_app.cmake)
include(cmake/create_test.cmake)

# Include module with fuction 'write_basic_package_version_file'
include(CMakePackageConfigHelpers)

set(LibList 
    libone
)

set(AppList 
    appone
)

# setup google-test
add_subdirectory(3rdparty/googletest-release-1.11.0)

foreach(lib ${LibList})
    add_subdirectory(libs/${lib})
endforeach()

foreach(app ${AppList})
    add_subdirectory(apps/${app})
endforeach()

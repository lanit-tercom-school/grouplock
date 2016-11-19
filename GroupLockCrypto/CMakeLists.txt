# Descryption of some variables used can be found here:
# http://cmake.org/Wiki/CMake_Useful_Variables

# =================== GENERAL SETTINGS =====================

# Minimum version of CMake required to configure the project
cmake_minimum_required(VERSION 3.1)

# Project name
project(glcrypto)

# Let's show the current OS we're building for
message(STATUS "Current system: ${CMAKE_SYSTEM_NAME} (${CMAKE_SYSTEM})")

# =================== PROJECT SETTINGS =====================

# Set directory with source files
set(SOURCE_ROOT "${PROJECT_SOURCE_DIR}/Sources")

# Specify source files
aux_source_directory(${SOURCE_ROOT} SOURCES)
file(GLOB HEADERS "${SOURCE_ROOT}/*.h")

# Build targets
set(LIBRARY_TARGET_NAME "${PROJECT_NAME}")
set(TEST_TARGET_NAME "${PROJECT_NAME}_TestRunner")

# ================== IMPORTED LIBRARIES ====================

# Specify IMPORTED libraries names
set(IMPORTED_LIBS libsodium)

# Set OS-specific stuff
if(UNIX)
  set(STATIC_LIBRARY_EXTENSION "a")
elseif(WIN32 OR WIN64)
  message(STATUS ${WIN32})
  set(STATIC_LIBRARY_EXTENSION "lib")
else(UNIX)
  message(FATAL_ERROR "This OS (${CMAKE_SYSTEM}) is not supported.")
endif(UNIX)

message(STATUS ${CMAKE_SYSTEM_NAME})

# Connect imported libraries
include_directories("${PROJECT_SOURCE_DIR}/${IMPORTED_LIBS}/include")
add_library(${IMPORTED_LIBS} STATIC IMPORTED)
set_property(TARGET ${IMPORTED_LIBS} PROPERTY IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/${IMPORTED_LIBS}/${CMAKE_SYSTEM_NAME}/${IMPORTED_LIBS}.${STATIC_LIBRARY_EXTENSION}")

# ========================= CUNIT ==========================

# CUnit is a lightweight unit testing library for C.
include_directories("${PROJECT_SOURCE_DIR}/cunit/include")
add_library(cunit STATIC IMPORTED)
set_property(TARGET cunit PROPERTY IMPORTED_LOCATION "${PROJECT_SOURCE_DIR}/cunit/${CMAKE_SYSTEM_NAME}/libcunit.${STATIC_LIBRARY_EXTENSION}")

# ========================= OUTPUT =========================

# Add output static library target
add_library(${LIBRARY_TARGET_NAME} STATIC ${SOURCES} ${HEADERS})
set_property(TARGET ${LIBRARY_TARGET_NAME} PROPERTY C_STANDARD 11)

# Link with external libraries
target_link_libraries(${LIBRARY_TARGET_NAME} ${IMPORTED_LIBS})

# ======================== TESTING =========================

set(TESTS_ROOT "${PROJECT_SOURCE_DIR}/Tests")
set(TEST_SUPPORTING_FILES ${TESTS_ROOT}/main.c ${TESTS_ROOT}/utils.c ${TESTS_ROOT}/suites.h)
aux_source_directory(${TESTS_ROOT}/suites TESTS)

# Add test target
add_executable(${TEST_TARGET_NAME} ${TEST_SUPPORTING_FILES} ${TESTS})
set_property(TARGET ${TEST_TARGET_NAME} PROPERTY C_STANDARD 11)
include_directories(${SOURCE_ROOT})
include_directories(${TESTS_ROOT})
target_link_libraries(${TEST_TARGET_NAME} ${LIBRARY_TARGET_NAME} cunit)

# Add post-build action: copy testing resources to the build directory
add_custom_command(TARGET ${TEST_TARGET_NAME} POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy_directory
                 ${TESTS_ROOT}/suites/resources $<TARGET_FILE_DIR:${TEST_TARGET_NAME}>/resources)

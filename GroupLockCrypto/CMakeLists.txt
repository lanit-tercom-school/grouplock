# Descryption of some variables used can be found here:
# http://cmake.org/Wiki/CMake_Useful_Variables

# =================== GENERAL SETTINGS =====================

# Minimum version of CMake required to configure the project
cmake_minimum_required(VERSION 2.8)

# Project name
project(glcrypto)

# Let's show the current OS we're building for
message(STATUS "Current system: ${CMAKE_SYSTEM_NAME} (${CMAKE_SYSTEM})")

# =================== PROJECT SETTINGS =====================

# Set directory with source files
set(SOURCE_ROOT "${PROJECT_SOURCE_DIR}/Source")

# Specify source files
aux_source_directory(${SOURCE_ROOT} SOURCES)
file(GLOB HEADERS "${SOURCE_ROOT}/*.h")

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

# ========================= OUTPUT =========================

# Add output static library target
add_library(${PROJECT_NAME} STATIC ${SOURCES} ${HEADERS})
add_executable(${PROJECT_NAME}-main ${SOURCES} ${HEADERS})

# Link with external libraries
target_link_libraries(${PROJECT_NAME} ${IMPORTED_LIBS})
target_link_libraries(${PROJECT_NAME}-main ${IMPORTED_LIBS})

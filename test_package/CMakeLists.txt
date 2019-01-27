cmake_minimum_required(VERSION 3.5.2)
project(test_package)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

set(CMAKE_VERBOSE_MAKEFILE TRUE)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

include(${CMAKE_BINARY_DIR}/conan_paths.cmake)

set(PKG_CONFIG_USE_CMAKE_PREFIX_PATH TRUE)

find_package(XercesC REQUIRED)

find_package(ICU REQUIRED COMPONENTS uc data)

find_package(CURL REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(ZLIB REQUIRED)

find_package(Threads REQUIRED)

find_package(xsd REQUIRED)

add_executable(${PROJECT_NAME}
    hello.cxx
    hello.hxx
    test_package.cpp)
    
target_link_libraries(${PROJECT_NAME} PUBLIC
    xsd::xsd 
    XercesC::XercesC
    ICU::uc
    ICU::data
    CURL::libcurl
    OpenSSL::SSL
    OpenSSL::Crypto
    ZLIB::ZLIB
    Threads::Threads
    dl)

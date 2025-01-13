cmake_minimum_required(VERSION 3.30)

project(newunit)
enable_language(Fortran)

add_library(lib SHARED lib.f90)

add_executable(main main.f90)

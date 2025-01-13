How to build and run:
Depending on your system, choose ifort or ifx
cmake -S . -B build -D CMAKE_BUILD_TYPE=Debug -G 'Unix Makefiles' -D CMAKE_Fortran_COMPILER=ifx
cmake --build build --config Debug
./build/main

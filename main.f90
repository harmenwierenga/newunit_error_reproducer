program main
    use iso_c_binding
    implicit none
    integer :: main_unit_number, error_value
    integer, parameter :: RTLD_LAZY = int(Z'00001')
    character(256) :: final_name
    type(c_ptr) :: shared_lib
    type(c_funptr) :: proc_address
    interface
        function dlopen(filename,mode) bind(c,name="dlopen")
            ! void *dlopen(const char *filename, int mode);
            use iso_c_binding
            implicit none
            type(c_ptr) :: dlopen
            character(c_char), intent(in) :: filename(*)
            integer(c_int), value :: mode
        end function

        function dlsym(handle,name) bind(c,name="dlsym")
            ! void *dlsym(void *handle, const char *name);
            use iso_c_binding
            implicit none
            type(c_funptr) :: dlsym
            type(c_ptr), value :: handle
            character(c_char), intent(in) :: name(*)
        end function

        function dlclose(handle) bind(c,name="dlclose")
            ! int dlclose(void *handle);
            use iso_c_binding
            implicit none
            integer(c_int) :: dlclose
            type(c_ptr), value :: handle
        end function
    end interface
 
    abstract interface
        subroutine lib_open_file() bind(C)
        end subroutine
    end interface
    procedure(lib_open_file), bind(C), pointer :: proc

    open(file='main.txt', newunit=main_unit_number, iostat=error_value)
    print *, 'File main.txt was opened, unit number ', main_unit_number, ', error value ', error_value 

    shared_lib = dlopen('./build/liblib.so'//c_null_char, RTLD_LAZY)
    if (.not. c_associated(shared_lib)) then
        print *, 'Library liblib.so failed to load'
        stop
    end if
    proc_address = dlsym(shared_lib, 'lib_open_file'//c_null_char)
    if (.not. c_associated(proc_address)) then
        print *, 'Function lib_open_file failed to load'
        stop
    end if
    call c_f_procpointer(proc_address, proc)
    call proc()
    inquire(unit=-129, name=final_name)
    print *, 'Unit -129 is connected to file: '//final_name
end program main

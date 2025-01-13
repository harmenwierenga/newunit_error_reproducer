subroutine lib_open_file() bind(C)
    integer :: lib_unit_number, lib_error_value
    open(file='lib.txt', newunit=lib_unit_number, iostat=lib_error_value)
    print *, 'lib.txt was openend, new unit number ', lib_unit_number, ', error value ', lib_error_value
end subroutine lib_open_file

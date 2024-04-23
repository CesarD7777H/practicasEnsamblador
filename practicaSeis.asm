; project.asm 

ExitProcess proto
.data

    ; numero de productos en existencia
    producto1 byte 50
    producto2 byte 31

    ; precios por productos
    precio1 byte 22
    precio2 byte 180


    ;dinero del cliente
    dinero byte 200
    ;credito del cliente
    credito byte 255
    ; numero de ventas
    numVentas byte 0

.code
    main proc

call venta_uno
call venta_credito

venta_uno: ; parte para hacer ventas con efectivo, uso de dec, inc y mov  
    mov al, producto1  
    dec al
    mov producto1, al
    mov bl ,numVentas
    inc bl
    mov numVentas, bl 

    call meter_producto
    call sacar_producto

    call venta_credito
    ret
meter_producto:
    xor rax, rax
    xor rbx, rbx
    mov rax, 1
    push rax
    ret 

sacar_producto: 
    pop rbx
    ret

venta_credito: ; parte para hacer ventas con credito, uso de mov, cmp, jxx
    mov ah, precio2 
    cmp dl, ah
    mov bl ,numVentas
    inc bl
    mov numVentas, bl 
    call meter_producto
    call cobro_efectivo
    call sacar_producto
    jl cobro_credito  ;

cobro_efectivo:
    mov cl, precio1
    mov dl, dinero
    sub dl, cl
    ret

cobro_credito:
    
    mov ecx, 12
    mov eax, 180
    mov edx, 0 
    div ecx  

    ret

        call ExitProcess
    main endp
end 

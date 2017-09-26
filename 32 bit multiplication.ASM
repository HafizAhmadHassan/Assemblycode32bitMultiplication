; 32bit multiplication [org 0x0100]               
jmp  start                 

start:  mov  cx, 32             ; initialize bit count to 32

; Here is Multiplication of   two Hexadecimal Number EEEEFFFF * 0000FFFF
	mov word[multiplicand+4],0xFFFF   ;lower
	mov word[multiplicand+4],0x0000   ; higher

	mov word[multiplicand+6],0x0000   ; higher

	mov word[multiplicand+2],0xEEEE
        mov word[multiplicand],0xFFFF     ;next higer

        mov word[multiplier],0xFFFF
	mov word[multiplier+2],0x0000     ;next lower
	
        mov word[result+2],0x0000     ;next lower
	mov word[result],0x0000       ;next lower
        mov word[result+4],0x0000     ;next lower
	mov word[result+6],0x0000     ;next lower

        mov bx,[multiplier+2]
        mov dx, [multiplier]   ; load multiplier in dx  

checkbit:
	shr  dx, 1                ; move right most bit in carry  
         
	jnc  skip                 ; skip addition if bit is zero  
              
	mov  ax, [multiplicand] ;take lower bit             
              
	add  [result], ax       ; add less significant word  
              
	mov  ax, [multiplicand+2]   
              
	adc  [result+2], ax     ; add more significant word  
        
	mov  ax, [multiplicand+4]   
                            
              
	adc  [result+4], ax       ; add less significant word  
	
	mov  ax, [multiplicand+6]   
                      
	adc  [result+6], ax     ; add more significant word  



;179/17
skip:   shl  word [multiplicand], 1

        rcl  word [multiplicand+2], 1 ; shift multiplicand left

        rcl  word [multiplicand+4], 1 ; shift multiplicand left

        rcl  word [multiplicand+6], 1 ; shift multiplicand left
             


	      cmp cx,16
	      jne l1
              mov dx,bx 
l1:           dec  cx                 ; decrement bit count

	      jnz  checkbit           ; repeat if bits left  
              mov  ax, 0x4c00         ; terminate program
               
              int  0x21



multiplicand: dd   0,2011123          ; 0000000000000000   0101100000100110        32 bit multiplicand 64bit space 
multiplier:   dd   0               ; 000000000000000000 0000000111110100  32 bit multiplier 
result:       dd   0,0                  ; 64bit result  




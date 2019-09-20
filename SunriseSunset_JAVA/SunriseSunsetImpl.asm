.386
.model flat,stdcall

.data 

_dayCons     dd    275,9,12,4,2,3,1,30
_GradeVar 	 dd    180
_compareVar  dd    360,0
_twoVar      dd    15,6,24,18
_threeVar    dd    0.9856,3.289
_fourVar	 dd    1.916,0.020,2,282.634
_fiveVar	 dd    0.91764,90,15
_arcoConst 	 dd    2 


_n1 dd 0 
_n2 dd 0 
_n3 dd 0
_n  dd 0
_lngHour    dd    0
_t          dd    0
_m          dd    0
_l          dd    0
_ra         dd    0
_LQuadrant	dd 	  0
_RQuadrant	dd    0

_day   		dd    0
_month 		dd    0
_year  		dd    0
_longitude  dd    0
_latitude   dd    0

resultado dd 0 

.code
_calculateN proc near
	finit
	fild _month
	fimul [_dayCons];275
	fidiv [_dayCons+4] ;9
	fstp _n1

	fild _month
	fiadd [_dayCons+4]   ;9
	fidiv [_dayCons+8] ;12
	frndint
	fstp _n2

	fild _year
	fild [_dayCons+12] ; 4
	fdiv
	frndint

	fild [_dayCons+12] ; 4
	fmul
	fild _year
	fsub
	fild [_dayCons+16] ; 2
	fadd
	fild [_dayCons+20] ; 3
	fdiv
	frndint
	fild [_dayCons+24] ; 1
	fadd
	fstp _n3

	fld _n1
	frndint
	fld _n2
	fld _n3
	fmul
	fsub
	fild _day
	fadd
	fild [_dayCons+28] ; 30
	fsub
	fstp _n

	ret
_calculateN endp

_calculateLngHour PROC NEAR   ; convert the longitude to hour value and calculate an approximate time.				
	fld _longitude
	fild [_twoVar] ;15
	fdiv
	fstp _lngHour

	ret  

_calculateLngHour ENDP

_sunRisingT PROC NEAR   ;sunRisingT() from C, calculates the t based on a rising Sun.

					

;----------calculo en FPU----------------

					fild [_twoVar+4]  ;6
					fld _lngHour
					fsub
					fild [_twoVar+8]  ;24
					fdiv
					fld _n
					fadd
					fstp _t

					;mov ax,word ptr [_t+2] ;para probarlo

;----------calculo en FPU----------------

					
					ret

_sunRisingT ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunSettingT PROC NEAR  ;sunSettingT() from C, calculates the t based on a setting Sun.

					

;----------calculo en FPU----------------

					
					fild [_twoVar+12]   ;18
					fld _lngHour
					fsub
					fild [_twoVar+8]    ;24
					fdiv
					fld _n
					fadd
					fstp _t

;----------calculo en FPU----------------

					
					ret

_sunSettingT ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunAnomaly PROC NEAR  ;_sunAnomaly() from C, calculates the t based on a setting Sun.

					

;----------calculo en FPU----------------

					
					fld [_threeVar] ; 0.9856
					fld _t
					fmul
					fld [_threeVar+4] ; 3.289
					fsub
					fstp _m


;----------calculo en FPU----------------

					
					ret

_sunAnomaly ENDP

;-----------------------------------------------------------------
;-----------------------------------------------------------------

_sunTrueLong PROC NEAR  ;_sunTrueLong() from C,

					

;----------calculo en FPU----------------

					
					fld _m
					call _toRadian
					call _sin
					fld [_fourVar] ; 1.916
					fmul

					fild [_fourVar+8] ; 2
					fld _m
					fmul
					call _toRadian
					call _sin

					fld [_fourVar+4] ; 0.020
					fmul

					fld _m
					fadd
					fadd
					fld [_fourVar+12] ; 282.634
					fadd
					call _compareGrados
					fst _l

					;mov dx,word ptr [_l]
					;mov ax,word ptr [_l+2]
					;mov word ptr [_masSig],ax
					;mov word ptr [_menosSig],dx

;----------calculo en FPU----------------

					
					ret

_sunTrueLong ENDP




;-----------------------------------------------------------------
;-----------------------------------------------------------------




_sunRightAscension PROC NEAR
					

;----------calculo en FPU----------------

					call _toRadian
					fptan
					fxch  st(1)
					call _toGrado
					fld [_fiveVar] ; 0.91764
					fmul
					call _toRadian

					fxch
					fpatan
					call _toGrado
					call _compareGrados
					fstp _ra

					fld _l
					fild [_fiveVar+4] ; 90
					fdiv
					frndint
					fild [_fiveVar+4] ; 90
					fmul
					fstp _LQuadrant

					fld _ra
					fild [_fiveVar+4] ; 90
					fdiv
					frndint
					fild [_fiveVar+4] ; 90
					fmul
					fstp _RQuadrant

					fld _ra
					fld _LQuadrant
					fld _RQuadrant
					fsub
					fadd

					fild [_fiveVar+8] ; 15
					fdiv
					fstp _ra

;----------calculo en FPU----------------

					
					ret

_sunRightAscension ENDP





;--------------------PROCEDIMIENTOS INTERNOS---------------
_toRadian proc near
					

;----------calculo en FPU----------------
					
					fldpi
					fmul
					fild _GradeVar
					fdiv

	;----------calculo en FPU----------------

					
					ret
_toRadian endP

_toGrado proc near
					

;----------calculo en FPU----------------
					
					fild _GradeVar
					fmul
					fldpi
					fdiv					

	;----------calculo en FPU----------------

					
					ret

_toGrado endP

_compareGrados proc near
					

;----------calculo en FPU----------------
					
					mov ax,0ffffh
					sahf
					fcom [_compareVar]; compara si el resultado es mayor o igual a 360
					fstsw ax
					fwait
					sahf
					ja gradosMayor ; mayor a 360
					jz gradosMayor ;igual a 360

					fcom [_compareVar+4] ; compara si el resultado es menor a 0
					fstsw ax
					fwait
					sahf
					jb gradosMenor
						
					jmp ValorCorrecto
				    
				  gradosMayor:
				  	fild [_compareVar] ; 360
				  	fsub
				  	jmp ValorCorrecto
				  gradosMenor:
				  	fild [_compareVar] ; 360
				  	fadd
				  ValorCorrecto:			
	;----------calculo en FPU----------------
					ret

_compareGrados endP

;-------Orden de instrucciones iniciales------
;;------------ Le hace un arcocoseno al valor en ST(0)
_arcSen proc near
;----------calculo en FPU----------------
					fld1
					fld st(1)
					fld st(0)

					fmul
					fsub
					fsqrt
					fld1
					fadd
					fpatan
					fild [_arcoConst]; 2
					fmul

	;----------calculo en FPU----------------
					ret
_arcSen endP

;-------Orden de instrucciones iniciales------
;   ;------------ Le hace un arcocoseno al valor en ST(0)
_arcCos proc near
					

;----------calculo en FPU----------------
					
					fld1
					fld st(1)
					fld st(0)
					fmul
					fsub
					fsqrt
					
					fxch ST(1)
					fld1 
					fadd

					fpatan
					fild [_arcoConst]; 2
					fmul
	;----------calculo en FPU----------------

					
					ret

	
_arcCos endP

_sin proc near     
	fild [_arcoConst];2
	fdiv
	fptan

	fxch ST(1)
	fld ST(0)
	fild [_arcoConst];2
	fmul
	fxch st(2)
	fxch

	fld st(0)
	fmul
	fadd

	fdiv
	ret
_sin endP

_cos proc near
	fild [_arcoConst];2
	fdiv
	fptan

	fxch

	fld ST(0)

	fmul

	fld ST(0)  ;tan^2(ang/2)

	fxch st(2)
	fxch

	fsub

	fxch

	fld1
	fadd

	fdiv

	ret
_cos endP

;--------------------PROCEDIMIENTOS INTERNOS---------------


Java_SunriseSunset_calcularHora proc JNIEnv:DWORD, jobject:DWORD,pDay:DWORD,pMonth:DWORD,pYear:DWORD,latitude:QWORD,longitude:QWORD
	mov ebx,pDay
	mov ecx,pMonth
	mov edx,pYear

	mov _day,ebx
	mov _month,ecx
	mov _year,edx


	mov ebx,dword ptr [latitude]
	mov ecx,dword ptr [latitude+8]
	mov dword ptr [_latitude],ebx
	mov dword ptr [_latitude+8],ebx

	mov ebx,dword ptr [longitude]
	mov ecx,dword ptr [longitude+8]
	mov dword ptr [_longitude],ebx
	mov dword ptr [_longitude+8],ebx

	;mov _latitude,ebx
	;mov _longitude,ecx

	call _calculateN
	;mov eax,_n

	call _calculateLngHour
	;mov eax,_lngHour

	call _sunRisingT
	;mov eax,_t

	call _sunAnomaly
	;mov eax,_m

	call _sunTrueLong
	;mov eax,_ra
	call _sunRightAscension
	mov eax,_ra

	
	ret
Java_SunriseSunset_calcularHora endP

END
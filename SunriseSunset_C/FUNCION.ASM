DGROUP         GROUP    _DATA, _BSS
.286

_DATA          SEGMENT WORD PUBLIC 'DATA'

				PUBLIC _masSig,_menosSig,_localT               ;variables accesible desde el programa C

_day     	dd    0
_month   	dd    0
_year    	dd    0

_dayCons 	dd    275,9,12,4,2,3,1,30
_GradeVar 	dd    180,360,24
_compareVar dd    360.0,0,1.0,-1.0
_compareTB  dd    24.0,0
_twoVar     dd    15,6,24,18
_threeVar   dd    0.9856,3.289
_fourVar	dd    1.916,0.020,2,282.634
_fiveVar	dd    0.91764,90,15
_arcoConst 	dd 		2
_declinCons dd    0.39782
_timeCons   dd    0.06571,6.622
_hCons      dd    360,15,0.06571,6.622
_localCons	dd    15

_n1    		dd    0
_n2      	dd    0
_n3   		dd    0
_n       	dd    0
_lngHour    dd    0
_t          dd    0
_m          dd    0
_l          dd    0
_ra         dd    0
_LQuadrant	dd 	  0
_RQuadrant	dd    0
_sinDec     dd    0
_cosDec     dd    0
_cosH       dd    0
_h          dd    0
_time       dd    0
_ut         dd    0
_localT     dd    0

_masSig		dd    0
_menosSig	dd 	  0

resultado   dd    1.3
_DATA          ENDS

_BSS           SEGMENT   WORD PUBLIC 'BSS'

			   EXTRN  _latitude:dword,_longitude:dword,_zenit:dword        ;variable externa

			   

_BSS           ENDS


_TEXT          SEGMENT BYTE PUBLIC 'CODE'
               ASSUME CS:_TEXT,DS:DGROUP,SS:DGROUP

			   PUBLIC _calculateN, _calculateLngHour, _sunRisingT, _sunSettingT,_sunAnomaly,_sunTrueLong,_sunRightAscension, _sunDeclination,_localHourAngle, _sunRisingH, _sunSettingH,_localMeanTime, _toUTC,_toLocalTime ;funciones accesibles desde el programa C

;-----------------------------------------------------------------------------------------------------------------------------------------------------

_calculateN    PROC  NEAR        ;calculateN1() from C, calculate the day of the year.
				 push  bp
			   mov   bp,sp
			   mov   bx,[bp+4]    		;recuperar variable 'year'
			   mov   cx,[bp+6]    		;recuperar variable 'month'
			   mov   dx,[bp+8]        ;recuperar variable 'day'
			   mov word ptr _day,dx   ;se mueve la variable desde c porque se necesita en dd (para el fpu).
			   mov word ptr _month,cx ;se mueve la variable desde c porque se necesita en dd (para   el fpu).
				 mov word ptr _year,bx  ;se mueve la variable desde c porque se necesita en dd (para el fpu).
				 xor 	 bx,bx
				 xor 	 cx,cx
				 xor 	 dx,dx

;----------calculo en FPU----------------

				 finit

			   fild _month
			   fimul [_dayCons]   ;mueve el 275
			   fidiv [_dayCons+4] ;mueve el valor 9
			   fstp _n1

			   fild _month
			   fiadd [_dayCons+4] ;9
			   fidiv [_dayCons+8] ;12
			   frndint
			   fstp _n2

			   fild _year
			   fild [_dayCons+12] ;4
			   fdiv
			   frndint

			   fild [_dayCons+12] ;4
			   fmul
			   fild _year
			   fsub
			   fild [_dayCons+16] ;2
			   fadd
			   fild [_dayCons+20] ;3
			   fdiv
			   frndint
			   fild [_dayCons+24] ;1
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
			   fild [_dayCons+28] ;30
			   fsub
			   fstp _n

;----------calculo en FPU----------------

		 	 	 mov   sp,bp
		 		 pop   bp
		 		 ret   2*3    ;sacar de la pila los parametros del proc

_calculateN   ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_calculateLngHour PROC NEAR   ;calculateLngHour() from C, convert the longitude to hour value and calculate an approximate time.

					push  bp
					mov   bp,sp

;----------calculo en FPU----------------

					fld _longitude
					fild [_twoVar] ;15
					fdiv
					fstp _lngHour

;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret   2*2

_calculateLngHour ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunRisingT PROC NEAR   ;sunRisingT() from C, calculates the t based on a rising Sun.

					push  bp
					mov   bp,sp

;----------calculo en FPU----------------

					fild [_twoVar+4]  ;6
					fld _lngHour
					fsub
					fild [_twoVar+8]  ;24
					fdiv
					fld _n
					fadd
					fstp _t

;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret

_sunRisingT ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunSettingT PROC NEAR  ;sunSettingT() from C, calculates the t based on a setting Sun.

					push  bp
					mov   bp,sp

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

					mov   sp,bp
					pop   bp
					ret

_sunSettingT ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunAnomaly PROC NEAR  ;_sunAnomaly() from C, calculates the t based on a setting Sun.

					push  bp
					mov   bp,sp

;----------calculo en FPU----------------

					fld [_threeVar] ; 0.9856
					fld _t
					fmul
					fld [_threeVar+4] ; 3.289
					fsub
					fstp _m

;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret

_sunAnomaly ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunTrueLong PROC NEAR  ;_sunTrueLong() from C,

					push  bp
					mov   bp,sp

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

;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret

_sunTrueLong ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunRightAscension PROC NEAR

					push  bp
					mov   bp,sp

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

					mov   sp,bp
					pop   bp
					ret

_sunRightAscension ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------
_sunDeclination PROC NEAR

					push bp
					mov  bp,sp

;----------calculo en FPU----------------

					fld  _l
					call _toRadian
					call _sin
					fld  [_declinCons]
					fmul
					fst _sinDec

					call _arcSen
					call _cos
					fstp _cosDec

					;mov dx,word ptr [_cosDec]
					;mov ax,word ptr [_cosDec+2]
					;mov word ptr [_masSig],ax
					;mov word ptr [_menosSig],dx

;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret

_sunDeclination ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_localHourAngle PROC NEAR

				push bp
				mov  bp,sp

;----------calculo en FPU----------------

				fld [_zenit]
				call _toRadian
				call _cos
				call _toGrado

				fld [_latitude]
				call _toRadian
				call _sin
				call _toGrado
				fld _sinDec
				fmul

				fsub

				fld [_latitude]
				call _toRadian
				call _cos
				call _toGrado
				fld _cosDec
				fmul

				fdiv
				
				call _compareCosH

				fstp _cosH


				;mov dx,word ptr [_cosH]
			 	;mov ax,word ptr [_cosH+2]
				;mov word ptr [_masSig],ax
				;mov word ptr [_menosSig],dx

;----------calculo en FPU----------------

				mov   sp,bp
				pop   bp
				ret

_localHourAngle ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunRisingH PROC NEAR

			push bp
			mov  bp,sp

;----------calculo en FPU----------------

			fild [_hCons] ;360
			fld  _cosH
			call _arcCos
			call _toGrado
			fsub
			fild [_hCons+4] ;15
			fdiv
			fstp _h

			;mov dx,word ptr [_h]
			;mov ax,word ptr [_h+2]
			;mov word ptr [_masSig],ax
			;mov word ptr [_menosSig],dx

;----------calculo en FPU----------------

			mov   sp,bp
			pop   bp
			ret

_sunRisingH ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_sunSettingH PROC NEAR

	 		push bp
			mov bp,sp

;----------calculo en FPU----------------

			fld _cosH
			call _arcCos
			call _toGrado
			fild [_hCons+4] ;15
			fdiv
			fstp _h

			;mov dx,word ptr [_h]
			;mov ax,word ptr [_h+2]
			;mov word ptr [_masSig],ax
			;mov word ptr [_menosSig],dx

;----------calculo en FPU----------------

			mov   sp,bp
			pop   bp
			ret

_sunSettingH ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_localMeanTime PROC NEAR

			push bp
			mov bp,sp

;----------calculo en FPU----------------

			fld _h
			fld _ra
			fld [_timeCons]
			fld _t
			fmul
			fsub
			fld [_timeCons+4]
			fsub
			fadd
			fstp _time

			;mov dx,word ptr [_time]
			;mov ax,word ptr [_time+2]
			;mov word ptr [_masSig],ax
			;mov word ptr [_menosSig],dx

;----------calculo en FPU----------------

			mov   sp,bp
			pop   bp
			ret

_localMeanTime ENDP
;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-----------------------------------------------------------------------------------------------------------------------------------------------------

_toUTC PROC NEAR

     push bp
     mov bp,sp

;----------calculo en FPU----------------
		fld _time
  		fld _lngHour
		fsub
		call _compareTiempo
		fstp _ut

;----------calculo en FPU----------------

		mov   sp,bp
		pop   bp
		ret

_toUTC ENDP

;-----------------------------------------------------------------------------------------------------------------------------------------------------

_toLocalTime PROC NEAR

     push bp
     mov bp,sp

;----------calculo en FPU----------------
	 fld _ut
	 fld _longitude
	 fild [_localCons]; 15
	 fdiv
	 frndint
	 fadd

	 fstp _localT


	 mov dx,word ptr [_localT]
	 mov ax,word ptr [_localT+2]
	 mov word ptr [_masSig],ax
	 mov word ptr [_menosSig],dx

;----------calculo en FPU----------------

		mov   sp,bp
		pop   bp
		ret

_toLocalTime ENDP





;-----------------------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------PROCEDIMIENTOS INTERNOS----------------------------------------------------------

_toRadian proc near
					push  bp
					mov   bp,sp

;----------calculo en FPU----------------

					fldpi
					fmul
					fild _GradeVar
					fdiv

	;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret
_toRadian endP

;-----------------------------------------------------------------------------------------------------------------------------------------------------

_toGrado proc near
					push  bp
					mov   bp,sp

;----------calculo en FPU----------------

					fild _GradeVar
					fmul
					fldpi
					fdiv

	;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret

_toGrado endP


;-----------------------------------------------------------------------------------------------------------------------------------------------------

_compareGrados proc near

					push  bp
					mov   bp,sp

;----------calculo en FPU----------------
			ciclo:

					fcom [_compareVar+4] ; compara si el resultado es menor a 0
					fnstsw ax
					fwait
					sahf
					jb gradosMenor

					fcom [_compareVar]; compara si el resultado es mayor o igual a 360
					fnstsw ax
					fwait
					sahf
					ja gradosMayor ; mayor a 360
					jz gradosMayor ;igual a 360

					

					jmp ValorCorrecto

				  gradosMayor:
				  	fild [_GradeVar+4] ; 360
				  	fsub
				  	jmp ciclo
				  gradosMenor:
				  	fild [_GradeVar+4] ; 360
				  	fadd
				  	jmp ciclo
				  valorCorrecto:

;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret

_compareGrados endP

;-----------------------------------------------------------------------------------------------------------------------------------------------------

_compareTiempo proc near

					push  bp
					mov   bp,sp

;----------calculo en FPU----------------
	ciclo1:
					fcom [_compareTB]; compara si el resultado es mayor o igual a 24
					fstsw ax
					fwait
					sahf
					ja gradosMayor1 ; mayor a 360
					jz gradosMayor1 ;igual a 360

					fcom [_compareTB+4] ; compara si el resultado es menor a 0
					fstsw ax
					fwait
					sahf
					jb gradosMenor1

					jmp ValorCorrecto1

				  gradosMayor1:
				  	fild [_GradeVar+8] ; 24
				  	fsub
				  	jmp ciclo
				  gradosMenor1:
				  	fild [_GradeVar+8] ; 24
				  	fadd
				  	jmp ciclo
				  ValorCorrecto1:

;----------calculo en FPU----------------

					mov   sp,bp
					pop   bp
					ret

_compareTiempo endP





;------------ Le hace un arcocoseno al valor en ST(0)

_arcSen proc near
					push  bp
					mov   bp,sp

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

					mov   sp,bp
					pop   bp
					ret

_arcSen endP

;-----------------------------------------------------------------------------------------------------------------------------------------------------

;------------ Le hace un arcocoseno al valor en ST(0)

_arcCos proc near
					push  bp
					mov   bp,sp

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

					mov   sp,bp
					pop   bp
					ret

_arcCos endP

;-----------------------------------------------------------------------------------------------------------------------------------------------------

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

;-----------------------------------------------------------------------------------------------------------------------------------------------------

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

;------- Revisa si el cosH está en el rango [-1,1]--------------------
_compareCosH proc near
			fcom [_compareVar+8] ;   1
			fstsw ax
			fwait
			sahf

			ja FueraDeRango

			fcom [_compareVar+12] ;   -1
			fstsw ax
			fwait
			sahf

			jb FueraDeRango

			xor ax,ax
			jmp vuelve


		FueraDeRango:
			mov ax,1;
		
		vuelve:
			ret
_compareCosH endP
;-----------------------------------------------------------------------------------------------------------------------------------------------------

;--------------------------------------------------------------------PROCEDIMIENTOS INTERNOS----------------------------------------------------------

_TEXT          ENDS
               END
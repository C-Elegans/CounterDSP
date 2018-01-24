EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:nVamp-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_01X02 J1
U 1 1 5A68D159
P 4000 3500
F 0 "J1" H 3919 3225 50  0000 C CNN
F 1 "CONN_01X02" H 3919 3316 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 4000 3500 50  0001 C CNN
F 3 "" H 4000 3500 50  0001 C CNN
	1    4000 3500
	-1   0    0    1   
$EndComp
$Comp
L AD8428 U1
U 1 1 5A68DA30
P 5200 3250
F 0 "U1" H 5150 3300 60  0000 L CNN
F 1 "AD8428" H 5000 3200 60  0000 L CNN
F 2 "Housings_SOIC:SOIC-8_3.9x4.9mm_Pitch1.27mm" H 5200 3250 60  0001 C CNN
F 3 "" H 5200 3250 60  0001 C CNN
	1    5200 3250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5A68DAB7
P 4200 3550
F 0 "#PWR01" H 4200 3300 50  0001 C CNN
F 1 "GND" H 4205 3377 50  0000 C CNN
F 2 "" H 4200 3550 50  0001 C CNN
F 3 "" H 4200 3550 50  0001 C CNN
	1    4200 3550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5A68DACD
P 4650 3050
F 0 "#PWR02" H 4650 2800 50  0001 C CNN
F 1 "GND" H 4655 2877 50  0000 C CNN
F 2 "" H 4650 3050 50  0001 C CNN
F 3 "" H 4650 3050 50  0001 C CNN
	1    4650 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 3450 4650 3450
$Comp
L CONN_01X03 J2
U 1 1 5A68DBA3
P 6900 2550
F 0 "J2" H 6978 2591 50  0000 L CNN
F 1 "CONN_01X03" H 6978 2500 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 6900 2550 50  0001 C CNN
F 3 "" H 6900 2550 50  0001 C CNN
	1    6900 2550
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR03
U 1 1 5A68DC4B
P 6700 2450
F 0 "#PWR03" H 6700 2300 50  0001 C CNN
F 1 "VDD" H 6717 2623 50  0000 C CNN
F 2 "" H 6700 2450 50  0001 C CNN
F 3 "" H 6700 2450 50  0001 C CNN
	1    6700 2450
	1    0    0    -1  
$EndComp
$Comp
L VEE #PWR04
U 1 1 5A68DD26
P 6700 2650
F 0 "#PWR04" H 6700 2500 50  0001 C CNN
F 1 "VEE" H 6718 2823 50  0000 C CNN
F 2 "" H 6700 2650 50  0001 C CNN
F 3 "" H 6700 2650 50  0001 C CNN
	1    6700 2650
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR05
U 1 1 5A68DD44
P 6450 2550
F 0 "#PWR05" H 6450 2300 50  0001 C CNN
F 1 "GND" H 6455 2377 50  0000 C CNN
F 2 "" H 6450 2550 50  0001 C CNN
F 3 "" H 6450 2550 50  0001 C CNN
	1    6450 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 2550 6700 2550
$Comp
L VEE #PWR06
U 1 1 5A68DD6E
P 5200 3700
F 0 "#PWR06" H 5200 3550 50  0001 C CNN
F 1 "VEE" H 5218 3873 50  0000 C CNN
F 2 "" H 5200 3700 50  0001 C CNN
F 3 "" H 5200 3700 50  0001 C CNN
	1    5200 3700
	-1   0    0    1   
$EndComp
$Comp
L VDD #PWR07
U 1 1 5A68DD7F
P 5200 2800
F 0 "#PWR07" H 5200 2650 50  0001 C CNN
F 1 "VDD" H 5217 2973 50  0000 C CNN
F 2 "" H 5200 2800 50  0001 C CNN
F 3 "" H 5200 2800 50  0001 C CNN
	1    5200 2800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5A68DD90
P 5400 3600
F 0 "#PWR08" H 5400 3350 50  0001 C CNN
F 1 "GND" H 5405 3427 50  0000 C CNN
F 2 "" H 5400 3600 50  0001 C CNN
F 3 "" H 5400 3600 50  0001 C CNN
	1    5400 3600
	1    0    0    -1  
$EndComp
$Comp
L ADA4528 U2
U 1 1 5A68E764
P 6850 3350
F 0 "U2" H 7191 3396 50  0000 L CNN
F 1 "ADA4528" H 7191 3305 50  0000 L CNN
F 2 "Housings_SSOP:TSSOP-8_3x3mm_Pitch0.65mm" H 6850 3350 50  0001 C CNN
F 3 "" H 6850 3350 50  0001 C CNN
	1    6850 3350
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 5A68E833
P 6050 3250
F 0 "C1" V 5798 3250 50  0000 C CNN
F 1 "100u" V 5889 3250 50  0000 C CNN
F 2 "Capacitors_SMD:C_1210_HandSoldering" H 6088 3100 50  0001 C CNN
F 3 "" H 6050 3250 50  0001 C CNN
	1    6050 3250
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 5A68E906
P 6200 3400
F 0 "R1" H 6270 3446 50  0000 L CNN
F 1 "15k" H 6270 3355 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6130 3400 50  0001 C CNN
F 3 "" H 6200 3400 50  0001 C CNN
	1    6200 3400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 5A68E976
P 6200 3550
F 0 "#PWR09" H 6200 3300 50  0001 C CNN
F 1 "GND" H 6205 3377 50  0000 C CNN
F 2 "" H 6200 3550 50  0001 C CNN
F 3 "" H 6200 3550 50  0001 C CNN
	1    6200 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 3250 6550 3250
$Comp
L VEE #PWR010
U 1 1 5A68EA0F
P 6750 3650
F 0 "#PWR010" H 6750 3500 50  0001 C CNN
F 1 "VEE" H 6768 3823 50  0000 C CNN
F 2 "" H 6750 3650 50  0001 C CNN
F 3 "" H 6750 3650 50  0001 C CNN
	1    6750 3650
	-1   0    0    1   
$EndComp
$Comp
L VDD #PWR011
U 1 1 5A68EA26
P 6750 3050
F 0 "#PWR011" H 6750 2900 50  0001 C CNN
F 1 "VDD" H 6767 3223 50  0000 C CNN
F 2 "" H 6750 3050 50  0001 C CNN
F 3 "" H 6750 3050 50  0001 C CNN
	1    6750 3050
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 5A68EA6E
P 6950 3650
F 0 "R3" V 6743 3650 50  0000 C CNN
F 1 "100k" V 6834 3650 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6880 3650 50  0001 C CNN
F 3 "" H 6950 3650 50  0001 C CNN
	1    6950 3650
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 5A68EAB7
P 6550 3850
F 0 "R2" H 6480 3804 50  0000 R CNN
F 1 "100" H 6480 3895 50  0000 R CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6480 3850 50  0001 C CNN
F 3 "" H 6550 3850 50  0001 C CNN
	1    6550 3850
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR012
U 1 1 5A68EB5F
P 6550 4000
F 0 "#PWR012" H 6550 3750 50  0001 C CNN
F 1 "GND" H 6555 3827 50  0000 C CNN
F 2 "" H 6550 4000 50  0001 C CNN
F 3 "" H 6550 4000 50  0001 C CNN
	1    6550 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6550 3700 6550 3450
Wire Wire Line
	6800 3650 6550 3650
Connection ~ 6550 3650
Wire Wire Line
	7100 3650 7250 3650
Wire Wire Line
	7250 3650 7250 3350
Wire Wire Line
	7150 3350 7600 3350
$Comp
L CONN_01X02 J3
U 1 1 5A68EC17
P 7800 3400
F 0 "J3" H 7878 3441 50  0000 L CNN
F 1 "CONN_01X02" H 7878 3350 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 7800 3400 50  0001 C CNN
F 3 "" H 7800 3400 50  0001 C CNN
	1    7800 3400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 5A68ED2E
P 7600 3450
F 0 "#PWR013" H 7600 3200 50  0001 C CNN
F 1 "GND" H 7605 3277 50  0000 C CNN
F 2 "" H 7600 3450 50  0001 C CNN
F 3 "" H 7600 3450 50  0001 C CNN
	1    7600 3450
	1    0    0    -1  
$EndComp
Connection ~ 7250 3350
$Comp
L C_Small C3
U 1 1 5A68F0C9
P 5900 2550
F 0 "C3" H 5992 2596 50  0000 L CNN
F 1 "100n" H 5992 2505 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 5900 2550 50  0001 C CNN
F 3 "" H 5900 2550 50  0001 C CNN
	1    5900 2550
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR014
U 1 1 5A68F115
P 5900 2450
F 0 "#PWR014" H 5900 2300 50  0001 C CNN
F 1 "VDD" H 5917 2623 50  0000 C CNN
F 2 "" H 5900 2450 50  0001 C CNN
F 3 "" H 5900 2450 50  0001 C CNN
	1    5900 2450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 5A68F134
P 5900 2650
F 0 "#PWR015" H 5900 2400 50  0001 C CNN
F 1 "GND" H 5905 2477 50  0000 C CNN
F 2 "" H 5900 2650 50  0001 C CNN
F 3 "" H 5900 2650 50  0001 C CNN
	1    5900 2650
	1    0    0    -1  
$EndComp
$Comp
L VEE #PWR016
U 1 1 5A68F153
P 5650 2700
F 0 "#PWR016" H 5650 2550 50  0001 C CNN
F 1 "VEE" H 5668 2873 50  0000 C CNN
F 2 "" H 5650 2700 50  0001 C CNN
F 3 "" H 5650 2700 50  0001 C CNN
	1    5650 2700
	-1   0    0    1   
$EndComp
$Comp
L C_Small C2
U 1 1 5A68F172
P 5650 2600
F 0 "C2" H 5742 2646 50  0000 L CNN
F 1 "100n" H 5742 2555 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 5650 2600 50  0001 C CNN
F 3 "" H 5650 2600 50  0001 C CNN
	1    5650 2600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 5A68F19D
P 5500 2500
F 0 "#PWR017" H 5500 2250 50  0001 C CNN
F 1 "GND" H 5505 2327 50  0000 C CNN
F 2 "" H 5500 2500 50  0001 C CNN
F 3 "" H 5500 2500 50  0001 C CNN
	1    5500 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 2500 5500 2500
$EndSCHEMATC

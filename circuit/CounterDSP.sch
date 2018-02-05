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
LIBS:symbols
LIBS:CounterDSP-cache
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
L TL072 U2
U 1 1 5A660239
P 7000 2950
F 0 "U2" H 7000 3200 50  0000 L CNN
F 1 "TL972" H 7000 3100 50  0000 L CNN
F 2 "" H 7000 2950 50  0001 C CNN
F 3 "" H 7000 2950 50  0001 C CNN
	1    7000 2950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5A660340
P 6900 3250
F 0 "#PWR01" H 6900 3000 50  0001 C CNN
F 1 "GND" H 6905 3077 50  0000 C CNN
F 2 "" H 6900 3250 50  0001 C CNN
F 3 "" H 6900 3250 50  0001 C CNN
	1    6900 3250
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR02
U 1 1 5A660388
P 6900 2650
F 0 "#PWR02" H 6900 2500 50  0001 C CNN
F 1 "+3.3V" H 6915 2823 50  0000 C CNN
F 2 "" H 6900 2650 50  0001 C CNN
F 3 "" H 6900 2650 50  0001 C CNN
	1    6900 2650
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5A6603FA
P 6300 3000
F 0 "R2" H 6370 3046 50  0000 L CNN
F 1 "1k" H 6370 2955 50  0000 L CNN
F 2 "" V 6230 3000 50  0001 C CNN
F 3 "" H 6300 3000 50  0001 C CNN
	1    6300 3000
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5A660429
P 6300 2700
F 0 "R1" H 6370 2746 50  0000 L CNN
F 1 "1k" H 6370 2655 50  0000 L CNN
F 2 "" V 6230 2700 50  0001 C CNN
F 3 "" H 6300 2700 50  0001 C CNN
	1    6300 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6700 3050 6700 3200
Wire Wire Line
	6700 3200 7450 3200
Wire Wire Line
	7450 3200 7450 2950
Wire Wire Line
	7300 2950 7600 2950
Wire Wire Line
	6700 2850 6300 2850
$Comp
L GND #PWR03
U 1 1 5A660459
P 6300 3150
F 0 "#PWR03" H 6300 2900 50  0001 C CNN
F 1 "GND" H 6305 2977 50  0000 C CNN
F 2 "" H 6300 3150 50  0001 C CNN
F 3 "" H 6300 3150 50  0001 C CNN
	1    6300 3150
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR04
U 1 1 5A66046A
P 6300 2550
F 0 "#PWR04" H 6300 2400 50  0001 C CNN
F 1 "+3.3V" H 6315 2723 50  0000 C CNN
F 2 "" H 6300 2550 50  0001 C CNN
F 3 "" H 6300 2550 50  0001 C CNN
	1    6300 2550
	1    0    0    -1  
$EndComp
$Comp
L TL072 U2
U 2 1 5A6604C6
P 7250 1400
F 0 "U2" H 7300 1650 50  0000 L CNN
F 1 "TL072" H 7300 1550 50  0000 L CNN
F 2 "" H 7250 1400 50  0001 C CNN
F 3 "" H 7250 1400 50  0001 C CNN
	2    7250 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 5A660532
P 7150 1700
F 0 "#PWR05" H 7150 1450 50  0001 C CNN
F 1 "GND" H 7155 1527 50  0000 C CNN
F 2 "" H 7150 1700 50  0001 C CNN
F 3 "" H 7150 1700 50  0001 C CNN
	1    7150 1700
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR06
U 1 1 5A660568
P 7150 1100
F 0 "#PWR06" H 7150 950 50  0001 C CNN
F 1 "+3.3V" H 7165 1273 50  0000 C CNN
F 2 "" H 7150 1100 50  0001 C CNN
F 3 "" H 7150 1100 50  0001 C CNN
	1    7150 1100
	1    0    0    -1  
$EndComp
Connection ~ 7450 2950
$Comp
L R R3
U 1 1 5A660654
P 6650 1350
F 0 "R3" H 6720 1396 50  0000 L CNN
F 1 "10k" H 6720 1305 50  0000 L CNN
F 2 "" V 6580 1350 50  0001 C CNN
F 3 "" H 6650 1350 50  0001 C CNN
	1    6650 1350
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 5A660686
P 6650 1650
F 0 "R4" H 6720 1696 50  0000 L CNN
F 1 "330" H 6720 1605 50  0000 L CNN
F 2 "" V 6580 1650 50  0001 C CNN
F 3 "" H 6650 1650 50  0001 C CNN
	1    6650 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 1400 7900 1400
Wire Wire Line
	7650 850  7650 1400
Wire Wire Line
	6650 850  6650 1200
Wire Wire Line
	6650 1500 6950 1500
$Comp
L CONN_01X02 J1
U 1 1 5A6607DE
P 6150 2050
F 0 "J1" H 6069 1775 50  0000 C CNN
F 1 "CONN_01X02" H 6069 1866 50  0000 C CNN
F 2 "" H 6150 2050 50  0001 C CNN
F 3 "" H 6150 2050 50  0001 C CNN
	1    6150 2050
	-1   0    0    1   
$EndComp
Wire Wire Line
	6350 2000 6650 2000
Wire Wire Line
	6650 2000 6650 1800
$Comp
L Earth #PWR07
U 1 1 5A660908
P 7600 2950
F 0 "#PWR07" H 7600 2700 50  0001 C CNN
F 1 "Earth" H 7600 2800 50  0001 C CNN
F 2 "" H 7600 2950 50  0001 C CNN
F 3 "" H 7600 2950 50  0001 C CNN
	1    7600 2950
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR08
U 1 1 5A660954
P 6950 1300
F 0 "#PWR08" H 6950 1050 50  0001 C CNN
F 1 "Earth" H 6950 1150 50  0001 C CNN
F 2 "" H 6950 1300 50  0001 C CNN
F 3 "" H 6950 1300 50  0001 C CNN
	1    6950 1300
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR09
U 1 1 5A66096D
P 6350 2100
F 0 "#PWR09" H 6350 1850 50  0001 C CNN
F 1 "Earth" H 6350 1950 50  0001 C CNN
F 2 "" H 6350 2100 50  0001 C CNN
F 3 "" H 6350 2100 50  0001 C CNN
	1    6350 2100
	1    0    0    -1  
$EndComp
$Comp
L dsPIC33FJ128GP802-I/SP U1
U 1 1 5A660BF5
P 1300 4900
F 0 "U1" H 4900 5287 60  0000 C CNN
F 1 "dsPIC33FJ128GP802-I/SP" H 4900 5181 60  0000 C CNN
F 2 "SPDIP28_300MC" H 4900 5140 60  0001 C CNN
F 3 "" H 1300 4900 60  0000 C CNN
	1    1300 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 5600 1300 5600
Wire Wire Line
	8500 5000 8650 5000
$Comp
L GND #PWR010
U 1 1 5A660E0B
P 1100 5600
F 0 "#PWR010" H 1100 5350 50  0001 C CNN
F 1 "GND" H 1105 5427 50  0000 C CNN
F 2 "" H 1100 5600 50  0001 C CNN
F 3 "" H 1100 5600 50  0001 C CNN
	1    1100 5600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 5A660E26
P 8650 5000
F 0 "#PWR011" H 8650 4750 50  0001 C CNN
F 1 "GND" H 8655 4827 50  0000 C CNN
F 2 "" H 8650 5000 50  0001 C CNN
F 3 "" H 8650 5000 50  0001 C CNN
	1    8650 5000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 5A660E41
P 8700 5800
F 0 "#PWR012" H 8700 5550 50  0001 C CNN
F 1 "GND" H 8705 5627 50  0000 C CNN
F 2 "" H 8700 5800 50  0001 C CNN
F 3 "" H 8700 5800 50  0001 C CNN
	1    8700 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 5800 8700 5800
$Comp
L +3.3V #PWR013
U 1 1 5A660E76
P 1100 6100
F 0 "#PWR013" H 1100 5950 50  0001 C CNN
F 1 "+3.3V" H 1115 6273 50  0000 C CNN
F 2 "" H 1100 6100 50  0001 C CNN
F 3 "" H 1100 6100 50  0001 C CNN
	1    1100 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 6100 1300 6100
$Comp
L +3.3V #PWR014
U 1 1 5A660EAB
P 8650 4900
F 0 "#PWR014" H 8650 4750 50  0001 C CNN
F 1 "+3.3V" H 8665 5073 50  0000 C CNN
F 2 "" H 8650 4900 50  0001 C CNN
F 3 "" H 8650 4900 50  0001 C CNN
	1    8650 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 4900 8500 4900
$Comp
L CP_Small C1
U 1 1 5A660FEE
P 8600 5700
F 0 "C1" V 8375 5700 50  0000 C CNN
F 1 "CP_Small" V 8466 5700 50  0000 C CNN
F 2 "" H 8600 5700 50  0001 C CNN
F 3 "" H 8600 5700 50  0001 C CNN
	1    8600 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	8700 5800 8700 5700
Text Label 7900 1400 0    60   ~ 0
TO_DSP
Text Label 8500 5100 0    60   ~ 0
TO_DSP
$Comp
L CONN_01X03 J2
U 1 1 5A66114A
P 9450 5500
F 0 "J2" H 9528 5541 50  0000 L CNN
F 1 "CONN_01X03" H 9528 5450 50  0000 L CNN
F 2 "" H 9450 5500 50  0001 C CNN
F 3 "" H 9450 5500 50  0001 C CNN
	1    9450 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 5500 9250 5500
Wire Wire Line
	9250 5600 8500 5600
$Comp
L GND #PWR015
U 1 1 5A6611F7
P 9250 5400
F 0 "#PWR015" H 9250 5150 50  0001 C CNN
F 1 "GND" H 9255 5227 50  0000 C CNN
F 2 "" H 9250 5400 50  0001 C CNN
F 3 "" H 9250 5400 50  0001 C CNN
	1    9250 5400
	1    0    0    -1  
$EndComp
Text Notes 5900 2300 0    60   ~ 0
Coil Connection\n
Text Notes 7450 2900 0    60   ~ 0
Virtual \nGround\n
Wire Wire Line
	7650 850  6650 850 
Connection ~ 7650 1400
$EndSCHEMATC

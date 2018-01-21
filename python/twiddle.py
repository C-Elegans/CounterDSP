import sys
import math

def floattofrac(x):
    if x==1.0:
        x_scaled = 2**15-1
    else:
        x_scaled = x * 2**15
    return int(round(x_scaled)) & 0xffff


if len(sys.argv) < 2:
    print("Usage: {} fftlen [outputfile]".format(sys.argv[0]))
    sys.exit(1)
fftlen = int(sys.argv[1])
file = sys.stdout
if len(sys.argv) == 3:
    file = open(sys.argv[2],"w")

twiddle_real = []
twiddle_imag = []

file.write("#include <dsp.h>\n")
file.write("const fractcomplex twiddleFactors[]\n")
file.write("__attribute__ ((space(auto_psv), aligned ({}*2)))= {{".format(fftlen))
for i in range(0,fftlen):
    theta = (-2*math.pi*i)/fftlen
    if i%4 == 0:
        file.write("\n")
    file.write("0x{:04x}, ".format(floattofrac(math.cos(theta))))
    file.write("0x{:04x}, ".format(floattofrac(math.sin(theta))))

file.write("\n};\n")
file.write("const fractcomplex twiddleFactorsCon[]\n")
file.write("__attribute__ ((space(auto_psv), aligned ({}*2)))= {{".format(fftlen))
for i in range(0,fftlen):
    theta = (-2*math.pi*i)/fftlen
    if i%4 == 0:
        file.write("\n")
    file.write("0x{:04x}, ".format(floattofrac(math.cos(theta))))
    file.write("0x{:04x}, ".format(floattofrac(-math.sin(theta))))
file.write("\n};\n")

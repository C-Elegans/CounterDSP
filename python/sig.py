import sys
import math
import numpy as np
samplerate = 5000
period = 0.012
frequency = 1/period
def f(t):
    y = math.sin(t*frequency*2*math.pi)
    y += -1/9.0 *math.sin(t*3*frequency*2*math.pi)
    y += 1/25.0 *math.sin(t*5*frequency*2*math.pi)
    return y
def floattofrac(x):
    if x==1.0:
        x_scaled = 2**15-1
    else:
        x_scaled = x * 2**15
    return int(round(x_scaled)) & 0xffff

def gen_sig():
    t = np.arange(0,period,1.0/samplerate)
    vf = np.vectorize(f)
    sig = vf(t)
    scale = np.sum(sig ** 2)
    print scale
    sig = sig/(scale*2)
    return sig

def write_sig(sig,f):
    vfloattofrac = np.vectorize(floattofrac)
    fracs = vfloattofrac(sig)
    f.write("#include <dsp.h>\n")
    f.write("const int siglen = {};\n".format(len(fracs)))
    f.write("fractional sig[] __attribute__((space(xmemory))) = {\n")
    for el in fracs.tolist():
        f.write("0x{:04x},\n".format(el))
    f.write("};\n")
    


def main():
    if len(sys.argv) != 2:
        print "Usage: {} output.c".format(sys.argv[0])

    f = open(sys.argv[1], "w")
    sig = gen_sig()
    
    write_sig(sig,f)
    f.close()

if __name__ == "__main__":
    main()

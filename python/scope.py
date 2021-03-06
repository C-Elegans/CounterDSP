import matplotlib.pyplot as plt
from matplotlib.widgets import Button, Slider
from matplotlib.ticker import FuncFormatter
import numpy as np
import math
import struct
import serial
import sys
trigval = 1.5
if len(sys.argv) > 1:
    trigval = float(sys.argv[1])
    print trigval

ser = serial.Serial('/dev/cu.usbserial-FTXLR71L', 500000, timeout=0.5);
current_delay = 1/10000.0


def ntovolts(n):
    n = n/65535.0
    vcc = 3.25
    return (vcc/2) + vcc*n
        
        
buflen = 256

plt.axis([0,buflen,0,1])

plt.ion()
ydata = [0] * buflen
ax = plt.axes()
ax.yaxis.grid()
ax.xaxis.grid()
ax.set_xlim([0,buflen*current_delay])
line, = plt.plot(ydata)
ymin = 0
ymax = 3.5
plt.ylim([ymin, ymax])
while True:
    # Synchronize to frame start
    b = '\0'
    while b != '\xaa':
        b = ser.read(1)

    if ser.read(1) != '\x55':
        b = 0
        continue
    count = struct.unpack("<h", ser.read(2))[0]
    buf = ser.read(buflen*2)
    ydata = np.fromstring(buf, dtype=np.dtype('<u2'))
    ydata = ntovolts(ydata.astype(np.float))
    if(np.any(ydata > trigval)):
        print count
        np.savetxt("samples.txt", ydata, fmt="%f", delimiter=',', newline='\n')
        line.set_xdata(np.arange(len(ydata))* current_delay)
        line.set_ydata(ydata)
        plt.draw()
        plt.pause(0.03)


import matplotlib.pyplot as plt
from matplotlib.widgets import Button, Slider
from matplotlib.ticker import FuncFormatter
import numpy as np
import math
import struct
import serial
import pdb
ser = serial.Serial('/dev/cu.usbserial-FTXLR71L', 115200, timeout=0.5);
current_delay = 1/10000.0
class Index(object):
    def stop(self, event):
        global ser
        ser.write(bytearray([0xaa, 0x55, 0x04]))
    def start(self, event):
        global ser
        ser.write(bytearray([0xaa, 0x55, 0x03]))
    def delay(self, event):
        global ser
        global current_delay
        global ax
        print(int(event))
        current_delay = zero_delay if event == 0 else event * one_delay + zero_delay
        ax.set_xlim([0,buflen*current_delay])
        ser.write(bytearray([0xaa, 0x55, 0x01, int(event)]))
    def trigger(self, event):
        global ser
        print(int(event))
        ser.write(bytearray([0xaa, 0x55, 0x02, 255-int(event)]))
    def offset(self, event):
        global ser
        ser.write(bytearray([0xaa, 0x55, 0x05, int(event)]))

def seconds(x, pos):
    si = True
    format = '%1.0f'
    sign = ''
    if x < 0:
        x = -x
        sign = '-'

    if x== 0:
        return '0'
    exp = int( math.floor( math.log10( x)))
    exp3 = exp - ( exp % 3)
    x3 = x / ( 10 ** exp3)

    if si and exp3 >= -24 and exp3 <= 24 and exp3 != 0:
        exp3_text = 'yzafpnum kMGTPEZY'[ ( exp3 - (-24)) / 3]
    elif exp3 == 0:
        exp3_text = ''
    else:
        exp3_text = 'e%s' % exp3

    return ( '%s'+format+'%ss') % ( sign, x3, exp3_text)

def ntovolts(n):
    n = n/65535.0
    vcc = 3.25
    return (vcc/2) + vcc*n
        
        
buflen = 512

plt.axis([0,buflen,0,1])

plt.ion()
ydata = [0] * buflen
ax = plt.axes()
ax.yaxis.grid()
ax.xaxis.grid()
ax.xaxis.set_major_formatter(FuncFormatter(seconds))
ax.set_xlim([0,buflen*current_delay])
line, = plt.plot(ydata)
ymin = 0
ymax = 3.5
plt.ylim([ymin, ymax])
callback = Index()

np.set_printoptions(formatter={'int':hex})
while True:
    b = '\0'
    #pdb.set_trace()
    while b != '\xaa':
        b = ser.read(1)

    if ser.read(1) != '\x55':
        b = 0
        continue
    buf = ser.read(512*2)
    # while len(buf) != 512*2:
    #     buf += ser.read(len(buf)-512*2)
    ydata = np.fromstring(buf, dtype=np.dtype('<i2'))
    ydata = ntovolts(ydata.astype(np.float))
    line.set_xdata(np.arange(len(ydata))* current_delay)
    line.set_ydata(ydata)
    plt.draw()
    plt.pause(0.03)


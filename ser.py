import serial, struct
ser = serial.Serial('/dev/cu.usbserial-FTXLR71L', 115200)
while True:
    data = ser.read(2)
    num = struct.unpack(">h", data)[0]
    print num

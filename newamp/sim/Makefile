all: amp.raw

%.raw: %.net
	ngspice -b -r $@ -o log.txt $<
%.net: %.sch
	gnetlist -g spice-sdb -o $@ $<

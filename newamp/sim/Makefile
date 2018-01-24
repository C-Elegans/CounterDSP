all: amp.raw

%.raw: %.net
	ngspice -b -r $@ $<
%.net: %.sch
	gnetlist -g spice-sdb -o $@ $<

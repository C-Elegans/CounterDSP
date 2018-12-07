import sys, getopt, math

def help():
    sys.stderr.write("Usage: pll.py -i inputfreq -o outputfreq\n")
    sys.exit(1)


def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hi:o:")
    except getopt.GetoptError as err:
        print str(err)
        help()
    inputfreq = 7.37
    outputfreq = 80.0
    for o,a in opts:
        if o == "-h":
            help()
        elif o == "-i":
            inputfreq = float(a)
        elif o == "-o":
            outputfreq = float(a)
        else:
            assert False, "unhandled option"
    print inputfreq
    print outputfreq

    closestfreq = 0
    pre = 0
    pll = 0
    post = 0
    vco = 0
    pfd = 0
    for pllpre in range (0,31):
        fpfd = inputfreq / (pllpre + 2.0)
        if fpfd > 8.0 or fpfd < 0.8:
            continue
        for plldiv in range (0,511):
            fvco = fpfd * (plldiv + 2)
            if fvco < 100 or fvco > 200:
                continue
            for pllpost in range(0,2):
                fout = fvco/ (2**(pllpost+1))
                if (fout > 80.0):
                    continue
                if abs(fout-outputfreq) < abs(closestfreq-outputfreq):
                    closestfreq = fout
                    pre = pllpre
                    post =pllpost
                    pll = plldiv
                    vco = fvco
                    pfd = fpfd
    print "Target freq: ", outputfreq
    print "Achieved freq: ", closestfreq
    print "PLLPRE: ", pre
    print "PLLDIV: ", pll
    print "PLLPOST: ", post
    print "PFD frequency: ", pfd
    print "VCO frequency: ", vco
            

if __name__ == "__main__":
    main()


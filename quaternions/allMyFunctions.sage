# Ok, now roughly cover the base with all those translates, not worrying about the vertical.


def CoverBase(radius,est,file):
    print 'applying horizontal translations to cover the base'
    orig_stdout = sys.stdout
    f = open('output/'+file, 'w')
    sys.stdout = f
    for m in range(-est,est):
        for n in range(-est,est):
            for o in range(-est,est):
                for p in range(-est,est):
                    for q in range(-est,est):
                        if MeasureBaseDist(m,n,o,p,q) < radius:
                            print([m,n,o,p,q])
    sys.stdout = orig_stdout
    f.close()

def CoverBall(radius,est,outfile,infile):

    print 'applying vertical translations'
    orig_stdout = sys.stdout
    fout = open('output/'+outfile,'w')
    fin = open('output/'+infile,'r')
    
    timestart = 0
    timeend = 0
    loop = 0
    
    for line in fin:
        loop = loop+1
        print 'starting loop '+str(loop)+' time for last loop was '+str(timeend-timestart)
        print 'estimated time remaining is '+str((timeend-timestart)*21363-(loop)*(timeend-timestart))
#NOTE: 21363 is the number of lines I know is in my file.  I don't know how to make sage find this number, given an input file.  well, use wc -l.
        timestart = time.time()
        t = eval(line)
        T = Translate(t[0],t[1],t[2],t[3],t[4])
        d = vertDisp(t[0],t[1],t[2],t[3],t[4])
        hfdi = est+d[0]
        hfdj = est+d[1]
        hfdk = est+d[2]
        hfui = est-d[0]
        hfuj = est-d[1]
        hfuk = est-d[2]
        irange = range(-hfdi,hfui)
        jrange = range(-hfdj,hfuj)
        krange = range(-hfdk,hfuk)
        for v1 in irange:
            for v2 in jrange:
                for v3 in krange:
                    Tv = TranslateVertically(v1,v2,v3)
                    if float(vectCygan(P0,Tv*T*P0)) < radius:
                        sys.stdout = fout
			print([v1,v2,v3,t[0],t[1],t[2],t[3],t[4]])
                        sys.stdout = orig_stdout
        timeend = time.time()
    
    fin.close()
    fout.close()
    return


def MakeCycles(infile,outfile,batchsize,batchnum,numlines):

#    s=60122077
#s is the number of lines in the infile.
    orig_stdout = sys.stdout
    fout = open('output/'+outfile+'.'+str(batchnum),'w')
    fin = open('output/'+infile,'r')

    timestart = 0
    timeend = 0
    time0 = time.time()
    elapsed = 0
    loop = 0
    numcycles = 0

    start = batchnum*batchsize+1
    end = (batchnum+1)*batchsize
    if end > numlines:
	end = numlines
    
    print 'start = '+str(start)
    print 'end = '+str(end)


    for line in fin:
        
        loop = loop+1
	if (start <= loop) and (loop <= end):

            elapsed = timeend-time0
            loopsdone = loop-start
            loopsleft = end-loop
            avglooptime = float(loopsdone/elapsed)
	    timeleft = loopsleft*avglooptime

            print 'starting loop '+str(loop)+' time for last loop was '+str(timeend-timestart)
            print ' so far I have found '+str(numcycles)+' cycles'
            print '  approximate time remaining for batch is '+str(timeleft)
            timestart = time.time()

	
            pows = eval(line)
            T = [ stringlet('Tvi',pows[0])+'*'+stringlet('Tvj',pows[1])+'*'+stringlet('Tvk',pows[2])+'*'+stringlet('T1',pows[3])+'*'+stringlet('Ti',pows[4])+'*'+stringlet('Tj',pows[5])+'*'+stringlet('Tk',pows[6])+'*'+stringlet('Tsig',pows[7]), TranslateVertically(pows[0],pows[1],pows[2])*Translate(pows[3],pows[4],pows[5],pows[6],pows[7]) ]
	    d = float(vectCygan(P0,T[1]*P0))
	    ctrs = TFDpoints
	    if d > 3.8:
	        ctrs = depth234pts
	    if d > 4.6:
	        ctrs = depth24pts
	    if d > 4.7:
	        ctrs = depth2pts
	    if d > 4.8:
	        print 'this should not happen.'
            for P in points:
               for Q in ctrs:
                   TQ = T[1]*Q[0][1]*Q[2][1]
                   l = level(P[1],TQ)
                   if l <= 4:
                        aa = points.index(P)
		        mainv = pysaev(invertWord(matrices[aa][0]))
                        gam1Pb = mainv*T[1]*Q[0][1]*Q[1][1]*Pinf
                        d = depth(gam1Pb)
                        if d <= 4:
                            c = [aa,TFDpoints.index(Q),pows]
		            sys.stdout = fout
                            print c
			    sys.stdout = orig_stdout
                            numcycles = numcycles+1
            timeend = time.time()

    fin.close()
    fout.close()
    print '   finished lines '+str(start)+' to '+str(end)+', found '+str(numcycles)+' cycles.'
    return batchnum







def nearestLattPt(z):
    z = H.coerce(z)
    fcorn = floor(z[0]) + floor(z[1])*i + floor(z[2])*j + floor(z[3])*k
    midcube = floor(z[0])+1/2 + (floor(z[1])+1/2)*i + (floor(z[2])+1/2)*j + (floor(z[3])+1/2)*k
    b = [0,1]
    dots = [midcube]
    for p in b:
        for q in b:
            for r in b:
                for s in b:
                    dots.append(fcorn+p+q*i+r*j+s*k)
    min = fcorn
    dist = (z-fcorn)*(z-fcorn).conjugate()
    for d in dots:
        di = (z-d)*(z-d).conjugate()
        #print d,di,dist, float(di) < float(dist)
        if float(di) < float(dist):
            min = d
            dist = di
    return min

def LPtrans(z):
    z = H.coerce(z)
    q = 0
    if not(z[0] in ZZ):
        q = -1
        z = z-(1+i+j+k)/2
    return [stringlet('T1',-z[0])+'*'+stringlet('Ti',-z[1])+'*'+stringlet('Tj',-z[2])+'*'+stringlet('Tk',-z[3])+'*'+stringlet('Tsig',q), Translate(-z[0],-z[1],-z[2],-z[3],q)]

vertWiggle = [['Id',Id], ['Tvi',Tvi], ['Tvj',Tvj], ['Tvk',Tvk], ['Tvi*Tvj',Tvi*Tvj], ['Tvi*Tvk',Tvi*Tvk], ['Tvj*Tvk',Tvj*Tvk], ['Tvi*Tvj*Tvk',Tvi*Tvj*Tvk]]

def spiderguess(C):
    #C is a cycle, consisting of A_a's index in matrices, A_c's index in TFDpoints, and powers for the translation part of gamma_3
    #returns the pair A_b, gamma_1
    
    found = 0
    Aa = matrices[C[0]]
    Aainvwd = invertWord(Aa[0])
    Aainv = pysaev(Aainvwd)

    gAc = TFDpoints[C[1]]
    g = gAc[0]
    Ac = gAc[1]
    pows = C[2]
    gam3t = [ stringlet('Tvi',pows[0])+'*'+stringlet('Tvj',pows[1])+'*'+stringlet('Tvk',pows[2])+'*'+stringlet('T1',pows[3])+'*'+stringlet('Ti',pows[4])+'*'+stringlet('Tj',pows[5])+'*'+stringlet('Tk',pows[6])+'*'+stringlet('Tsig',pows[7]), TranslateVertically(pows[0],pows[1],pows[2])*Translate(pows[3],pows[4],pows[5],pows[6],pows[7]) ]
    
    gamm1Pb = Aainv*gam3t[1]*g[1]*Ac[1]*Pinf
    s = gamm1Pb[2][0]
    if not(s == 0):
        gamm1Pb = gamm1Pb*s^(-1)
    else:
        found = 1
        return [['Id',Id],['Id',Id]]
    

    d = depth(gamm1Pb)
    levdpoints = []
    if d == 1:
        levdpoints = depth1pts
    if d == 2:
        levdpoints = depth2pts
    if d == 3:
        levdpoints = depth3pts
    if d == 4:
        levdpoints = depth4pts
    if len(levdpoints) == 0:
        print 'error: bad depth.'
        return []
    
    for p in levdpoints:
        if gamm1Pb == p[1]:
            found = 1
            name = levdpoints[0][0]+levdpoints[1][0]
            mat = levdpoints[0][1]*levdpoints[1][1]
            
            return [ [name,mat], ['Id',Id]]

    z = gamm1Pb[1][0]
    nlp = H.coerce(nearestLattPt(z))
    t = LPtrans(nlp)
    
    Thgamm1Pb = t[1]*gamm1Pb
    vert = H.coerce(Thgamm1Pb[0][0])
    v1 = -floor(vert[1])
    v2 = -floor(vert[2])
    v3 = -floor(vert[3])
    tvwd = stringlet('Tvi',v1)+'*'+stringlet('Tvj',v2)+'*'+stringlet('Tvk',v3)
    tv = [tvwd, TranslateVertically(v1,v2,v3)]
    
    TvThgamm1Pb = tv[1]*Thgamm1Pb
    
    found = 0
    for p in levdpoints:
       candidate = p[0][1]*p[2][1]
       s = candidate[2][0]
       if not(s == 1):
           candidate = candidate*s^(-1)
       for wig in vertWiggle:
           wcand = wig[1]*candidate
           if wcand == TvThgamm1Pb:
               found = 1
               gamm1name = invertWord(t[0])+'*'+invertWord(tv[0])+'*'+wig[0]+'*'+p[0][0]
               gamm1 = pysaev(invertWord(t[0]))*pysaev(invertWord(tv[0]))*wig[1]*p[0][1]
               return [p[1],[gamm1name, gamm1]]
           
    if found == 0:
        print 'found nothing :('
    return 

def findMagmaRelation(C):
    
    B = spiderguess(C)
        
    Aa = matrices[C[0]]

    gAc = TFDpoints[C[1]]
    g = gAc[0]
    Ac = gAc[1]

    Acinvwd = invertWord(Ac[0])
    Acinv = pysaev(Acinvwd)
    pows = C[2]
    gam3t = [ stringlet('Tvi',pows[0])+'*'+stringlet('Tvj',pows[1])+'*'+stringlet('Tvk',pows[2])+'*'+stringlet('T1',pows[3])+'*'+stringlet('Ti',pows[4])+'*'+stringlet('Tj',pows[5])+'*'+stringlet('Tk',pows[6])+'*'+stringlet('Tsig',pows[7]), TranslateVertically(pows[0],pows[1],pows[2])*Translate(pows[3],pows[4],pows[5],pows[6],pows[7]) ]
    
    gamm3 = [gam3t[0]+'*'+g[0], gam3t[1]*g[1]]

    gamm3invwd = invertWord(gamm3[0])
    gamm3inv = pysaev(gamm3invwd)
    gamma = Acinv*gamm3inv*Aa[1]*B[1][1]*B[0][1]
    
    gammdiag = matrix([[gamma[0][0],0,0],[0,gamma[1][1],0],[0,0,gamma[2][2]]])
    
    s = 0
    foundiag = 0
    g = []
    while (s < 288) and (foundiag == 0):
        g = G288[s]
        if gammdiag == g[1]:
            foundiag = 1
            if gamma == gammdiag:
                return '('+Ac[0]+')^-1*('+gamm3[0]+')^-1*('+Aa[0]+')*('+B[1][0]+')*('+B[0][0]+') = '+g[0]
        if gammdiag == -g[1]:
            foundiag = 1
            if gamma == gammdiag:
                return '('+Ac[0]+')^-1*('+gamm3[0]+')^-1*('+Aa[0]+')*('+B[1][0]+')*('+B[0][0]+') = '+g[0]
        s += 1
    if foundiag == 0:
        print 'could not identify diagonal!'

    ginv = pysaev(invertWord(g[0]))
    trPart = ginv*gamma
    
    if trPart[0][0] == -1:
        gamma = -gamma
    
    trPart = ginv*gamma

    z = trPart[1][2]
    nlp = H.coerce(nearestLattPt(z))
    t = LPtrans(nlp)
    
    ttrPart = t[1]*trPart
    vert = H.coerce(ttrPart[0][2])
    v1 = -floor(vert[1])
    v2 = -floor(vert[2])
    v3 = -floor(vert[3])
    tvwd = stringlet('Tvi',v1)+'*'+stringlet('Tvj',v2)+'*'+stringlet('Tvk',v3)
    tv = [tvwd, TranslateVertically(v1,v2,v3)]
    
    tvttrPart = tv[1]*ttrPart
    
    tinvwd = invertWord(t[0])
    tinv = pysaev(tinvwd)
    tvinvwd = invertWord(tv[0])
    tvinv = pysaev(tvinvwd)
    
    if not((gamma == g[1]*tinv*tvinv) or (gamma == -g[1]*tinv*tvinv)):
        print 'oh no! something went wrong.'
    
    return '('+Ac[0]+')^-1*('+gamm3[0]+')^-1*('+Aa[0]+')*('+B[1][0]+')*('+B[0][0]+') = ('+g[0]+')*('+tinvwd+')*('+tvinvwd+')'


def WriteMagmaFile(infile,outfile):

    timestart = 0
    timeend = 0

    orig_stdout = sys.stdout
    fout = open('output/'+outfile,'w')
    fin = open('output/'+infile,'r')

    print 'printing generators, and relations coming from the finite group...'

    sys.stdout = fout

    print '//To use this file, navigate to the appropriate directory, run magma, and do this:'
    print '// > load "quaternions.m";\n\n'

    print '//Gamma_infty\n'

    print '//For just the stabilizer of infinity, uncomment this:'
    print '//F<T1,Ti,Tj,Tk,Tsig,Tvi,Tvj,Tvk,Ri,Rsig,Ci,Csig,Rj,Rk,Cj,Ck> := FreeGroup(16);\n'

    print '//For the whole group, uncomment this:'
    print 'F<T1,Ti,Tj,Tk,Tsig,Tvi,Tvj,Tvk,Ri,Rsig,Ci,Csig,Rj,Rk,Cj,Ck, ',
    for m in matrices:
	print m[0],
	if not(matrices.index(m) == len(matrices)-1):
            print ',',
    print '> := FreeGroup('+str(len(matrices)+16)+');\n'

    print '\nId := F!1;'
    print 'T1inv := F.1^-1;'
    print 'Tiinv := F.2^-1;'
    print 'Tjinv := F.3^-1;'
    print 'Tkinv := F.4^-1;'
    print 'Tsiginv := F.5^-1;'
    print 'Tviinv := F.6^-1;'
    print 'Tvjinv := F.7^-1;'
    print 'Tvkinv := F.8^-1;'
    print 'Riinv := F.9^-1;'
    print 'Rsiginv := F.10^-1;'
    print 'Ciinv := F.11^-1;'
    print 'Csiginv := F.12^-1;'
    print 'Rjinv := F.13^-1;'
    print 'Rkinv := F.14^-1;'
    print 'Cjinv := F.15^-1;'
    print 'Ckinv := F.16^-1;'


    s = 17
    for m in matrices:
	print m[0]+'inv := F.'+str(s)+'^-1;'
        s += 1
    
    print '\n'

    print '//Relations'
    print '//Gamma_infinity'
    print '//Finite part'
    print '//Relations among the R\'s (A1)'
    print 'R1 := Ri^4 = F!1;'
    print 'R2 := Ri^2*Rsig^(-3) = F!1;'
    print 'R3 := (Ri*Rsig)^3 = F!1;'
    print 'R4 := Ri^(-1)*Rsig*Ri^(-1)*Rsig*Ri^(-1)*Rsig^(-2) = F!1;'

    print '//Relations among the C\'s (A2)'
    print 'R5 := Ci^2 = F!1;'
    print 'R6 := Csig^3 = F!1;'
    print 'R7 := (Ci*Csig)^3 = F!1;'

    print '//Relations between R\'s and C\'s (A4)'
    print 'R8 := (Ri,Ci) = F!1;'
    print 'R9 := (Rsig,Csig) = F!1;'
    print 'R10 := Ci*Rsig*Ci^(-1) = Ri*Rsig^4*Ri;'
    print 'R11 := Csig*Ri*Csig^(-1) = Rsig*Ri*Rsig^(-1);'
    print '//Translation part (A3)'
    print '//Everyone commutes with the Tv\'s'
    print 'R12 := (T1,Tvi) = F!1;'
    print 'R13 := (T1,Tvj) = F!1;'
    print 'R14 := (T1,Tvk) = F!1;'
    print 'R15 := (Ti,Tvi) = F!1;'
    print 'R16 := (Ti,Tvj) = F!1;'
    print 'R17 := (Ti,Tvk) = F!1;'
    print 'R18 := (Tj,Tvi) = F!1;'
    print 'R19 := (Tj,Tvj) = F!1;'
    print 'R20 := (Tj,Tvk) = F!1;'
    print 'R21 := (Tk,Tvi) = F!1;'
    print 'R22 := (Tk,Tvj) = F!1;'
    print 'R23 := (Tk,Tvk) = F!1;'
    print 'R24 := (Tsig,Tvi) = F!1;'
    print 'R25 := (Tsig,Tvj) = F!1;'
    print 'R26 := (Tsig,Tvk) = F!1;'
    print 'R27 := (Tvi,Tvj) = F!1;'
    print 'R28 := (Tvi,Tvk) = F!1;'
    print 'R29 := (Tvj,Tvk) = F!1;'
    print '//Commutatiors of horizontal translations are vertical translations'
    print 'R30 := (T1,Ti) = Tvi^(-2);'
    print 'R31 := (T1,Tj) = Tvj^(-2);'
    print 'R32 := (T1,Tk) = Tvk^(-2);'
    print 'R33 := (T1,Tsig) = Tvi^(-1)*Tvj^(-1)*Tvk^(-1);'
    print 'R34 := (Ti,Tj) = Tvk^2;'
    print 'R35 := (Ti,Tk) = Tvj^(-2);'
    print 'R36 := (Tj,Tk) = Tvi^2;'
    print 'R37 := (Ti,Tsig) = Tvi*Tvj^(-1)*Tvk;'
    print 'R38 := (Tj,Tsig) = Tvi*Tvj*Tvk^(-1);'
    print 'R39 := (Tk,Tsig) = Tvi^(-1)*Tvj*Tvk;'
    print '//That one about Tsigma'
    print 'R40 := T1*Ti*Tj*Tk = Tsig^2*Tvi*Tvj^(-1)*Tvk;'
    print '//Interactions between the finite part and the translation part (A5)'
    print '//Conjugate the T\'s by the R\'s '
    print 'R41 := Ri*T1*Ri^(-1) = Ti;'
    print 'R42 := Ri*Ti*Ri^(-1) = T1^(-1)*Tvi*Tvj*Tvk;'
    print 'R43 := Ri*Tj*Ri^(-1) = Tk;'
    print 'R44 := Ri*Tk*Ri^(-1) = Tj^(-1)*Tvi*Tvj*Tvk;'
    print 'R45 := Ri*Tsig*Ri^(-1) = Tsig^(-1)*Ti*Tk*Tvj*Tvk^(-1);'
    print 'R46 := Ri*Tvi*Ri^(-1) = Tvi;'
    print 'R47 := Ri*Tvj*Ri^(-1) = Tvj;'
    print 'R48 := Ri*Tvk*Ri^(-1) = Tvk;'
    print 'R49 := Rsig*T1*Rsig^(-1) = Tsig;'
    print 'R50 := Rsig*Ti*Rsig^(-1) = T1^(-1)*Tk^(-1)*Tsig*Tvj*Tvk^2;'
    print 'R51 := Rsig*Tj*Rsig^(-1) = T1^(-1)*Ti^(-1)*Tsig*Tvi^2*Tvk;'
    print 'R52 := Rsig*Tk*Rsig^(-1) = T1^(-1)*Tj^(-1)*Tsig*Tvi*Tvj^2;'
    print 'R53 := Rsig*Tsig*Rsig^(-1) = T1^(-1)*Tsig;'
    print 'R54 := Rsig*Tvi*Rsig^(-1) = Tvi;'
    print 'R55 := Rsig*Tvj*Rsig^(-1) = Tvj;'
    print 'R56 := Rsig*Tvk*Rsig^(-1) = Tvk;'
    print '//Conjugate the T\'s by the C\'s'
    print 'R57 := Ci*T1*Ci^(-1) = T1*Tvj^(-1)*Tvk^(-1);'
    print 'R58 := Ci*Ti*Ci^(-1) = Ti*Tvj^(-1)*Tvk^(-1);'
    print 'R59 := Ci*Tj*Ci^(-1) = Tj^(-1)*Tvi;'
    print 'R60 := Ci*Tk*Ci^(-1) = Tk^(-1)*Tvi;'
    print 'R61 := Ci*Tsig*Ci^(-1) = Tj^(-1)*Tk^(-1)*Tsig*Tvj;'
    print 'R62 := Ci*Tvi*Ci^(-1) = Tvi;'
    print 'R63 := Ci*Tvj*Ci^(-1) = Tvj^(-1);'
    print 'R64 := Ci*Tvk*Ci^(-1) = Tvk^(-1);'
    print 'R65 := Csig*T1*Csig^(-1) = T1;'
    print 'R66 := Csig*Ti*Csig^(-1) = Tj;'
    print 'R67 := Csig*Tj*Csig^(-1) = Tk;'
    print 'R68 := Csig*Tk*Csig^(-1) = Ti;'
    print 'R69 := Csig*Tsig*Csig^(-1) = Tsig;'
    print 'R70 := Csig*Tvi*Csig^(-1) = Tvj;'
    print 'R71 := Csig*Tvj*Csig^(-1) = Tvk;'
    print 'R72 := Csig*Tvk*Csig^(-1) = Tvi;'



    print '\n//Relations from cycles\n'
    
    sys.stdout = orig_stdout
    s=73
    print 'finding magma relations'
    v = 0
#v is the number of cycles, which is tbd.
    for line in fin:
        if (s-72)%1000 == 1:
            print 'starting loop '+str(s-72)
            print 'it took '+str(timeend-timestart)+' to find the last 1000.'
#	    print 'approximate time remaining is '+str((v/1000)*(timeend-timestart))
            timestart = time.time()

	C = eval(line)
	rel = findMagmaRelation(C)
        sys.stdout = fout
	print 'R'+str(s)+' := '+rel+';'
	sys.stdout = orig_stdout
        if (s-72)%1000 == 0:
            timeend = time.time()
	s = s+1

    print 'finishing up the magma file...'
    sys.stdout = fout
    print '\n\n//For the stabilizer of infinity, uncomment the next two lines:'
    print '//rels := {',
    t = 1
    while t <= 72:
        print 'R'+str(t),
        if not(t == 72):
            print ',',
        t += 1

    print '};\n'
    print '//G := quo<F|rels>;\n\n'



    print '//For the whole group, uncomment the next two lines:'
    print 'rels := {',
    t = 1
    while t < s:
        print 'R'+str(t),
        if not(t == s-1):
            print ',',
        t += 1

    print '};\n'

    print 'G := quo<F|rels>;'
    
    sys.stdout = orig_stdout
    
    fin.close()
    fout.close()
    return    


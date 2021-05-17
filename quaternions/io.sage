#These functions assist with reading from and writing to files.  Also, sometimes just making strings.
    
def stringlet(g,pow):
    if pow == 0:
        return 'Id'
    if pow == 1:
        return g
    if pow < 0:
        h = g.split('inv')
        if len(h) == 1:
            if pow == -1:
                return g+'inv'
            return g+'inv'+'^'+str(-pow)
        if len(h) == 2:
            if pow == -1:
		return h[0]
            return h[0]+'^'+str(-pow)
    return g+'^'+str(pow)


def invertWord(word):
    pieces = word.split('*')
    pieces.reverse()
    drow = ''
    for s in range(len(pieces)):
        g = pieces[s]
        k = g.split('^')
        h = k[0].split('inv')
        if len(h) == 1:
            if not(h[0] == 'Id') and not (h[0] == 'I0'):
               drow = drow+h[0]+'inv'
            if (h[0] == 'I0') or (h[0] == 'Id'):
                drow = drow+h[0]
        if len(h) == 2:
            drow = drow+h[0]+h[1]
        if len(k) == 2:
            drow = drow+'^'+k[1]
        if (s < len(pieces)-1):
            drow = drow+'*'
    return drow


def pysaev(word):
    return eval(word.replace('^','**'))


#Never use this if plannning to eval.  Only if planning to load!!!!
def printMat(M):
    print 'matrix([',
    for s in range(M.nrows()):
        print '[',
        for t in range(M.ncols()):
            print M[s][t],
            if t < M.ncols()-1:
                print',',
        print ']',
        if s < M.nrows()-1:
            print ',',
    print '])',

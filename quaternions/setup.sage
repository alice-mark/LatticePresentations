import sys
import time

# Make the quaternions!

H.<i,j,k> = QuaternionAlgebra(-1, -1)

sigma1 = (1/2)*(1+i+j+k)
sigmai = (1/2)*(1-i+j+k)
sigmaj = (1/2)*(1+i-j+k)
sigmak = (1/2)*(1+i+j-k)

units = [1,i,j,k,sigma1,sigma1^2,sigmai,sigmai^2,sigmaj,sigmaj^2,sigmak,sigmak^2]

#################################################
#Here are all the points and matrices:

Id = matrix([[1,0,0],[0,1,0],[0,0,1]])

Pinf = matrix([[1],[0],[0]])

P0 = matrix([[0],[0],[1]])
I0 = matrix([[0,0,1],[0,-1,0],[1,0,0]])

P2 = matrix([[(i+j)/2],[0],[1]])
A2 = matrix([[-1,0,i+j],[0,1,0],[i+j,0,1]])
A2inv = matrix([[1,0,-i-j],[0,1,0],[-i-j,0,-1]])

P31 = matrix([[(1/3)*(i-j+k)],[0],[1]])

P32 = matrix([[(1/3)*(-i+j-k)],[0],[1]])

P33 = matrix([[(-1+3*i-j-k)/6],[(1+3*i+j+k)/6],[1]])

P34 = matrix([[(-1-i+3*j+k)/6],[(1+3*i+j+k)/6],[1]])

P35 = matrix([[(-1+i+j+3*k)/6],[(1+3*i+j+k)/6],[1]])

P41 = matrix([[i/2],[0],[1]])
A41 = matrix([[i,0,1],[0,-1,0],[2,0,-i]])
A41inv = A41

P42 = matrix([[(i+j+k)/2],[0],[1]])
A42 = matrix([[i+j+k,0,2],[0,-1,0],[2,0,-(i+j+k)]])
A42inv = A42

P43 = matrix([[(-1+i+j+k)/4],[(i+j)/2],[1]])

P44 = matrix([[(-1-i+j+k)/4],[(i+j)/2],[1]])

P45 = matrix([[(-1+i-j+k)/4],[(i+j)/2],[1]])

P46 = matrix([[(-1-i-j+k)/4],[(i+j)/2],[1]])

P47 = matrix([[(-1+i+j-k)/4],[(i+j)/2],[1]])

P48 = matrix([[(-1-i+j-k)/4],[(i+j)/2],[1]])

P49 = matrix([[(-1+i-j-k)/4],[(i+j)/2],[1]])

P410 = matrix([[(-1-i-j-k)/4],[(i+j)/2],[1]])

#Gamma_infinity

#Horizontal translations
T1 = matrix([[1,-1,sigma1^2],[0,1,1],[0,0,1]])
T1inv = matrix([[1,1,sigma1^4],[0,1,-1],[0,0,1]])
Ti = matrix([[1,i,sigma1^2],[0,1,i],[0,0,1]])
Tiinv = matrix([[1,-i,sigma1^4],[0,1,-i],[0,0,1]])
Tj = matrix([[1,j,sigma1^2],[0,1,j],[0,0,1]])
Tjinv = matrix([[1,-j,sigma1^4],[0,1,-j],[0,0,1]])
Tk = matrix([[1,k,sigma1^2],[0,1,k],[0,0,1]])
Tkinv = matrix([[1,-k,sigma1^4],[0,1,-k],[0,0,1]])
Tsig = matrix([[1,sigma1^2,sigma1^2],[0,1,sigma1],[0,0,1]])
Tsiginv = matrix([[1,sigma1^5,sigma1^4],[0,1,-sigma1],[0,0,1]])

#Vertical translations
Tvi = matrix([[1,0,i],[0,1,0],[0,0,1]])
Tviinv = matrix([[1,0,-i],[0,1,0],[0,0,1]])
Tvj = matrix([[1,0,j],[0,1,0],[0,0,1]])
Tvjinv = matrix([[1,0,-j],[0,1,0],[0,0,1]])
Tvk = matrix([[1,0,k],[0,1,0],[0,0,1]])
Tvkinv = matrix([[1,0,-k],[0,1,0],[0,0,1]])

#Finite part
Ri = matrix([[1,0,0],[0,i,0],[0,0,1]])
Rsig = matrix([[1,0,0],[0,sigma1,0],[0,0,1]])
Riinv = Ri^3
Rsiginv = Rsig^5
Ci = matrix([[i,0,0],[0,i,0],[0,0,i]])
Csig = matrix([[sigma1,0,0],[0,sigma1,0],[0,0,sigma1]])
Csiginv = Csig^2

#helpful extras
Rj = matrix([[1,0,0],[0,j,0],[0,0,1]])
Rk = matrix([[1,0,0],[0,k,0],[0,0,1]])
Rkinv = Rk^3
Rjinv = Rj^3
Cj = matrix([[j,0,0],[0,j,0],[0,0,j]])
Ck = matrix([[k,0,0],[0,k,0],[0,0,k]])
Ciinv = Ci
Cjinv = Cj
Ckinv = Ck

matrices_gamma_infinity = [['T1',T1], ['T1inv',T1inv], ['Ti',Ti], ['Tiinv',Tiinv], ['Tj',Tj], ['Tjinv',Tjinv], ['Tk',Tk], ['Tkinv',Tkinv], ['Tsig',Tsig], ['Tsiginv',Tsiginv], ['Tvi',Tvi], ['Tviinv',Tviinv], ['Tvj',Tvj], ['Tvjinv',Tvjinv], ['Tvk',Tvk], ['Tvkinv',Tvkinv], ['Ri',Ri], ['Riinv',Riinv], ['Rsig',Rsig], ['Rsiginv',Rsiginv], ['Ci',Ci], ['Csig',Csig], ['Csiginv',Csiginv],['Rj',Rj], ['Rjinv',Rj^3], ['Rk',Rk], ['Rkinv',Rk^3], ['Cj',Cj], ['Ck',Ck]]

translation_matrices_gamma_infinity = [['T1',T1], ['T1inv',T1inv], ['Ti',Ti], ['Tiinv',Tiinv], ['Tj',Tj], ['Tjinv',Tjinv], ['Tk',Tk], ['Tkinv',Tkinv], ['Tsig',Tsig], ['Tsiginv',Tsiginv], ['Tvi',Tvi], ['Tviinv',Tviinv], ['Tvj',Tvj], ['Tvjinv',Tvjinv], ['Tvk',Tvk], ['Tvkinv',Tvkinv]]


#More matrices
A31 = I0*Tviinv*Tvj*Tvkinv*I0
A31inv = I0*Tvi*Tvjinv*Tvk*I0

A32 = A31inv
A32inv = A31

A33 = I0*Tsig*Tkinv*T1inv*Tvj*I0
A33inv = I0*Tvjinv*T1*Tk*Tsiginv*I0

A34 = I0*Tk*Tvkinv*Tvjinv^2*I0
A34inv = I0*Tvj^2*Tvk*Tkinv*I0

A35 = I0*Tsiginv*Tk*Ti*Tvkinv^3*Tvjinv^2*Tviinv*I0
A35inv = I0*Tvi*Tvj^2*Tvk^3*Tiinv*Tkinv*Tsig*I0

A43 = I0*Ti*T1inv*Tvkinv*Tvjinv*I0
A43inv = I0*Tvj*Tvk*T1*Tiinv*I0

A44 = I0*Tk*Ti*Tvkinv^2*Tvjinv^3*I0
A44inv = I0*Tvj^3*Tvk^2*Tiinv*Tkinv*I0

A45 = I0*Tkinv*Ti*Tvkinv*Tvj^2*Tviinv*I0
A45inv = I0*Tvi*Tvjinv^2*Tvk*Tiinv*Tk*I0

A46 = I0*Ti*T1*Tvkinv^2*Tviinv*I0
A46inv = I0*Tvi*Tvk^2*T1inv*Tiinv*I0

A47 = I0*Tj*T1inv*Tvk*Tviinv*I0
A47inv = I0*Tvi*Tvkinv*T1*Tjinv*I0

A48 = I0*Tk*Tj*Tvjinv^2*Tvi*I0
A48inv = I0*Tviinv*Tvj^2*Tjinv*Tkinv*I0

A49 = I0*Tkinv*Tj*Tvk*Tvj*Tviinv^2*I0
A49inv = I0*Tvi^2*Tvjinv*Tvkinv*Tjinv*Tk*I0

A410 = I0*Tj*T1*Tvjinv*I0
A410inv = I0*Tvj*T1inv*Tjinv*I0



matrices = [['I0',I0],['A2',A2],['A31',A31],['A32',A32],['A33',A33],['A34',A34],['A35',A35],['A41',A41],['A42',A42],['A43',A43],['A44',A44],['A45',A45],['A46',A46],['A47',A47],['A48',A48],['A49',A49],['A410',A410]]
points = [['P0',P0],['P2',P2],['P31',P31],['P32',P32],['P33',P33],['P34',P34],['P35',P35],['P41',P41],['P42',P42],['P43',P43],['P44',P44],['P45',P45],['P46',P46],['P47',P47],['P48',P48],['P49',P49],['P410',P410]]

# these are the scalars who clear the denominators of the prism points of each of their respective depths.  Technically d1 should contain 1, not empty, but that would be silly and would just mean we mutiply by 1 a lot.
d1 = []
d2 = [1+i]
d3 = [1-j-k]
d4 = [2]

depths = [d2,d3,d4]


#The finite group of order 288

Grot = [['Id',Id],['Ri',Ri],['Rj',Rj],['Rk',Rk],['Ri^2', Ri^2],['Ri^3',Ri^3],['Rj^3',Rj^3],['Rk^3',Rk^3],['Rsig',Rsig],['Rsig^2',Rsig^2],['Rsig^4',Rsig^4],['Rsig^5',Rsig^5],['Rj^3*Rsig^2',Rj^3*Rsig^2],['Rk*Rsig',Rk*Rsig],['Rj*Rsig^2',Rj*Rsig^2],['Rk^3*Rsig',Rk^3*Rsig],['Rk^3*Rsig^2',Rk^3*Rsig^2],['Ri*Rsig',Ri*Rsig],['Rk*Rsig^2',Rk*Rsig^2],['Ri^3*Rsig',Ri^3*Rsig],['Ri^3*Rsig^2',Ri^3*Rsig^2],['Rj*Rsig',Rj*Rsig],['Ri*Rsig^2',Ri*Rsig^2],['Rj^3*Rsig',Rj^3*Rsig]]

Gconj = [['Id',Id],['Ci',Ci],['Cj',Cj],['Ck',Ck],['Csig',Csig],['Csig^2',Csig^2],['Cj*Csig^2',Cj*Csig^2],['Ck*Csig',Ck*Csig],['Ck*Csig^2',Ck*Csig^2],['Ci*Csig',Ci*Csig],['Ci*Csig^2',Ci*Csig^2],['Cj*Csig',Cj*Csig]]

def grpProd(g1,g2):
    if g1[0] == 'Id':
        return g2
    if g2[0] == 'Id':
        return g1
    return [g1[0]+'*'+g2[0],g1[1]*g2[1]]

G288 = []
for g2 in Gconj:
    for g1 in Grot:
        G288.append(grpProd(g1,g2))

# unwind to the 24-cell
#A TFD point is all the data of a point and also where it came from.  it goes like: [finGpElt, mat(from matrices), pt(from points)]

#orig_stdout = sys.stdout
#f = open('output/24cell.sage', 'w')
#sys.stdout = f


#print 'TFDpoints = [',

#TFDpoints = []
#for #g in G288:
    #for p in points:
   #     gp = g[1]*p[1]
  #      d = gp[2][0]
 #       gp = gp*d^-1
#        found = 0
        #s = 0
       # while (found == 0) and (s < len(TFDpoints)):
      #      pgp = TFDpoints[s][0][1]*TFDpoints[s][2][1]
     #       pd = pgp[2][0]
    #        pgp = pgp*pd^-1
   #         if gp == pgp:
  #              found = 1
 #           s += 1
#        if found == 0:
          #  m = matrices[points.index(p)]
         #   TFDpoints.append([g, m, p])
        #    print '[[\''+g[0]+'\',',
       #     printMat(g[1])
      #      print '], [\''+m[0]+'\' ,',
     #       printMat(m[1])
    #        print '], [\''+p[0]+'\' ,',
   #         printMat(p[1])
  #          print ']],'
 #           
#print '[] ]'


#sys.stdout = orig_stdout
#f.close()

#print(len(TFDpoints))

load('output/24cell.sage')
TFDpoints.remove([])

#print(len(TFDpoints))






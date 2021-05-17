#This file is about applying translations.

def Translate(m,n,o,p,q):
    if m >= 0:
        T1m = T1^m
    if m < 0:
        T1m = T1inv^-m
    if n >= 0:
        Tin = Ti^n
    if n < 0:
        Tin = Tiinv^-n
    if o >= 0:
        Tjo = Tj^o
    if o < 0:
        Tjo = Tjinv^-o
    if p >= 0:
        Tkp = Tk^p
    if p < 0:
        Tkp = Tkinv^-p
    if q >= 0:
        Tsigq = Tsig^q
    if q < 0:
        Tsigq = Tsiginv^-q
    return T1m*Tin*Tjo*Tkp*Tsigq

def TranslateVertically(v1,v2,v3):
    if v1 >= 0:
        Tviv1 = Tvi^v1
    if v1 < 0:
        Tviv1 = Tviinv^-v1
    if v2 >= 0:
        Tvjv2 = Tvj^v2
    if v2 < 0:
        Tvjv2 = Tvjinv^-v2
    if v3 >= 0:
        Tvkv3 = Tvk^v3
    if v3 < 0:
        Tvkv3 = Tvkinv^-v3
    return Tviv1*Tvjv2*Tvkv3


def vertDisp(m,n,o,p,q):
    q = Translate(m,n,o,p,q)*P0
    t1 = H.coerce(q[0][0])[1]
    t2 = H.coerce(q[0][0])[2]
    t3 = H.coerce(q[0][0])[3]
    return [t1,t2,t3]

def MeasureBaseDist(m,n,o,p,q):
    P = Translate(m,n,o,p,q)*P0
    v1 = floor(H.coerce(P[0][0])[1])
    v2 = floor(H.coerce(P[0][0])[2])
    v3 = floor(H.coerce(P[0][0])[3])
    if v3 < 0:
        P = Tvk^-v3*P
    if v3 > 0:
        P = Tvkinv^v3*P
    if v2 < 0:
        P = Tvj^-v2*P
    if v2 > 0:
        P = Tvjinv^v2*P
    if v1 < 0:
        P = Tvi^-v1*P
    if v1 > 0:
        P = Tviinv^v1*P
    #print(P)
    return float(vectCygan(P0,P))


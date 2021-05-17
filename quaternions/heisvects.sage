#this file contains a bunch of functions for handling vectors.

#Compute the inner product of two vectors
def ip(v1,v2):
    return v2[2][0].conjugate()*v1[0][0] + v2[1][0].conjugate()*v1[1][0] + v2[0][0].conjugate()*v1[2][0]

#Test if a (rational) number (not a vector) is in the ring of integers.
def IsIntegral(n):
    if (H.coerce(n)[0] in ZZ) & (H.coerce(n)[1] in ZZ) & (H.coerce(n)[2] in ZZ) & (H.coerce(n)[3] in ZZ):
        return True
    else:
        if (H.coerce(n)[0]+1/2 in ZZ) & (H.coerce(n)[1]+1/2 in ZZ) & (H.coerce(n)[2]+1/2 in ZZ) & (H.coerce(n)[3]+1/2 in ZZ):
            return True
        else:
            return False

#Given a vector v, find its primitive integral lift.  Only works on points of depth up to 4 because what it does is multiply by all possible scalars that could clear the denominator and then checks if the coordinates are integral.
def PrimIntLift(v):
    if IsIntegral(v[0][0]) & IsIntegral(v[1][0]) & IsIntegral(v[2][0]):
        return v
    for d in depths:
        for q in d:
            for u in units:
                w = v*u*q
                if IsIntegral(w[0][0]) & IsIntegral(w[1][0]) & IsIntegral(w[2][0]):
                    return w
    print("PIL: depth greater than 5")
    return False
   
#Find the level between two points.  Only works on points of depth up to 4.
def level(v1,v2):
    prod = ip(PrimIntLift(v1),PrimIntLift(v2))
    return prod.conjugate()*prod

#Find the depth of a point.  Only works on points of depth up to 4.
def depth(v):
    PIL = PrimIntLift(v)
    if PIL == False:
        return False
    v3 = H.coerce(PIL[2][0])
    return v3.conjugate()*v3

def invert(quatern):
    q = H.coerce(quatern)
    return q.conjugate()*(q.conjugate()*q)^-1

def vectCygan(v1,v2):
    nv1 = v1*invert(v1[2][0])
    nv2 = v2*invert(v2[2][0])
    prod = 2*ip(nv1,nv2)
    return (prod.conjugate()*prod)[0]^(1/4)

import numpy

def lagprim(n):
    rot = int(numpy.floor(numpy.sqrt(n)))
    alle_tall = list(range(n))
    alle_tall[1]=0
    for i in range(rot+1):
        if alle_tall[i] != 0:
            j = i
            while i*j <n:
                alle_tall[i*j] = 0
                j = j+1
    return [tall for tall in alle_tall if tall != 0]


def generate_primes(start, stop):
    rot = int(numpy.floor(numpy.sqrt(stop)))
    primtall = lagprim(rot)
    alle_tall = list(range(start,stop))
    for tall in primtall:
        for i,rr in enumerate(alle_tall):
            if rr % tall == 0:
                alle_tall[i] = 0
    return [tall for tall in alle_tall if tall !=0]

def check_key(p,q,e):
    (g,x,y) = gcd((p-1)*(q-1), e)
    return  g == 1

def gcd(a, b):
    if a == 0:
        return (b, 0, 1)
    g, y, x = gcd(b%a,a)
    return (g, x - (b//a) * y, y)

    
def mult_inverse(a, m):
    g, x, y = gcd(a, m)
    if g != 1:
        raise Exception('Ingen invers.')
    return x%m

def RSA_encrypt(n,e, klar):
    encrypted_list = []
    for single_word in klar:
        encrypted_list.append(powermod(single_word,e,n))
    return encrypted_list

def powermod(N, e,m):
    binary = bin(e)[2:]
    powers =[N % m]
    for n in range(1,len(binary)):
        powers.append(powers[-1]*powers[-1] % m)
    M = 1
    powerindex = 0
    for bit in reversed(binary):
        if bit == '1':
            M = M * powers[powerindex] % m
        powerindex = powerindex + 1
    return M
def powermod2(N,e,m):
    if (N==0):
        return 0
    if (e==1):
        return 1
    M = 0
    if (e%2 ==0): #e partall
        M = powermod(N,e//2,m)
        M = (M * M) % m
    else: # e oddetall
        M = N % m
        M = (M * powermod(N,e-1,m))%m
    return M

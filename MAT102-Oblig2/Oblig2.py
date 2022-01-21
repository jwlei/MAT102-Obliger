import RSA

import math

#Oppgave A 
#[1041706,4139999] blir til 'BERG' 'EN  '.

#Oppgave B
#HEI SJEF blir [H(07)E(04)I(08) (99),S(18)J(09)E(04)F(05)]
#              [07040899,18090405]


#Oppgave C
def c():
    T = [70040899,18090405]
    n = 104523733
    e = 137
    U = RSA.RSA_encrypt(n,e,T)
#HEI SJEF ble kryptert til [288931760181, 318393863655].

#Oppgave D
def PrimtallfaktorN(n):
    x = round(math.sqrt(n))
    T = RSA.lagprim(x)

    for i in reversed(T):
        a = n % i
        if a == 0:
            p = i
            break

    q = round(n / p)
    return(p,q)  

#Variabler
n = 104523733
e = 137

p,q = PrimtallfaktorN(n)
print("p = " , p , " q = " , q)
#Primtallene blir P = 7243, Q = 14431.

#Oppgave E
#For at (n,e) skal være en korrekt valgt nøkkel så må e være slik at e er mindre enn pq = (p - 1)(q - 1) og den største
#fellesnevneren for (e, ((pq) = (p - 1)(q - 1)) er 1.

validKey = RSA.check_key(p,q,e)
print(validKey)
#Returner true.

#Oppgave F
#Finner den ved å kalle på multi inverse metoden
d = RSA.mult_inverse(e,(p-1)*(q-1))
print(d)
#nøkkel: 41190593

#Beskjeden 'HEI SJEF' == [7040899,18090405] ble kryptert til [288931760181, 318393863655].
kryptert = [288931760181, 318393863655]
V = RSA.RSA_encrypt(n,d,kryptert)
print(V == [70040899,18090405])

#Oppgave G
#Ikke gjennomført

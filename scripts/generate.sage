# pasta curve p
p = 0x40000000000000000000000000000000224698fc094cf91b992d30ed00000001
f = GF(p)
# order n curve
b = 0x34524F71A21A7096C6AD51A6A7FE7A43D76D8E4277CB9048EDC87AB655E55142
n = 2^12
log_n = n.log(2)

def get_group_generator(e,n):
    log_n = n.log(2)
    g = e.random_point()
    G = (e.order()//n) * g
    assert (n * G).is_zero()
    return G

e = EllipticCurve(f, [1, b])
G = get_group_generator(e, n)
print(e)

R = e.random_element()
H = [R + i * G for i in range(2 ^ log_n)]
L = [h.xy()[0] for h in H]
S = [L[i] for i in range(0, n, 2)]
S_prime = [L[i] for i in range(1, n, 2)]

for i in range(log_n, 0, -1):
    n = 1 << i
    nn = n // 2

    for iso in e.isogenies_prime_degree(2):
        psi = iso.x_rational_map()
        if len(set([psi(x) for x in S])) == nn:
            break
    S = [psi(x) for x in S[:nn]]
    S_prime = [psi(x) for x in S_prime[:nn]]
    e = iso.codomain()
if is_not_find == False:
    print(G, R)

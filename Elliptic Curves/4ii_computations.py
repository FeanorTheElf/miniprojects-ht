from math import sqrt, gcd

def eval(r, a, b, l, m):
    return r * l**4 + a * l**2 * m**2 + b/r * m**4

def is_square(n):
    if n < 0:
        return False
    return int(sqrt(n))**2 == n

def can_prove_has_sol(r, a, b):
    for l in range(50):
        for m in range(50):
            if (l != 0 or m != 0) and gcd(l, m) == 1:
                if is_square(eval(r, a, b, l, m)):
                    return True
    return False

def can_prove_has_no_sol(r, a, b):
    for q in [64, 81, 25, 49]:
        squares = { x**2 % q for x in range(q) }
        sol_count_mod_q =  len([(l, m) 
            for l in range(q) 
            for m in range(q) 
            if eval(r, a, b, l, m)%q in squares])
        if sol_count_mod_q == 1:
            return True
    return False

def is_nice(r, a, b):
    return (r < 0 and a <= 0 and b >= 0) or \
        can_prove_has_no_sol(r, a, b) or \
        can_prove_has_sol(r, a, b)

def sqrfree_factors(b):
    pos_factors = [n for n in range(2, b + 1) if b%n == 0]
    pos_sqrfree_factors = [n 
        for n in pos_factors 
        if len([m for m in pos_factors if n % m**2 == 0]) == 0]
    return [
        1, -1, 
        *pos_sqrfree_factors, 
        *[-n for n in pos_sqrfree_factors]
    ]

def is_curve_nice(a, b):
    a1 = -2 * a
    b1 = a**2 - 4 * b
    for r in sqrfree_factors(b):
        if not is_nice(r, a, b):
            return False
    for r in sqrfree_factors(b1):
        if not is_nice(r, a1, b1):
            return False
    return True

for a in range(100):
    for b in range(100):
        if a**2 - 4 * b != 0 and len(sqrfree_factors(b)) >= 14:
            if is_curve_nice(a, b):
                print(a, b, len(sqrfree_factors(b)))

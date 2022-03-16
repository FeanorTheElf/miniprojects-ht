R.<a,b,c,y,u,v,V> = PolynomialRing(QQ, 7)

# slope of the tangent at (0, y)
line1_num = b
line1_den = 2 * y
# slope of the tangent at (u, v)
line2_num = 3 * u^2 + 2 * a * u + b
line2_den = 2 * v

I = ideal(
    y^2 - c, # (0, y) in E
    v^2 - u^3 - a * u^2 - b * u - c, # (u, v) in E
    u * line1_den^2 + a * line1_den^2 - line1_num^2, # x([2](0, y)) = u
    v * line1_den + y * line1_den + u * line1_num, # [2](0, y) = (u, v)
    2 * u * line2_den^2 + a * line2_den^2 - line2_num^2, # x([2](u, v)) = 0
    -y * line2_den + v * line2_den - u * line2_num, # [2](u, v) = (0, -y)
)

print(I.elimination_ideal([a, b, c]))

# slope of line through (0, -y) and (u, v)
line3_num = v + y
line3_den = u
#assert (u * line3_den^2 + a * line3_den^2 - line3_num^2) in I

def j_inv(a1, a2, a3, a4, a6):
    b2 = a1^2 + 4*a2
    b4 = 2*a4+a1*a3
    b6 = a3**2 + 4*a6**2
    b8 = a1**2*a6 + 4*a2*a6 - a1*a3*a4 + a2*a3**2 - a4**2
    c4 = b2**2 - 24*b4
    D = -b2**2*b8 - 8*b4**3 - 27*b6**2 + 9*b2*b4*b6
    return (c4**3, D)


j_inv_E1_num, j_inv_E1_den = j_inv(0, a, 0, b, c)
j_inv_E2_num, j_inv_E2_den = j_inv(V + 1, V, V, 0, 0)

statement = j_inv_E1_num * j_inv_E2_den - j_inv_E1_den * j_inv_E2_num

I = ideal([-b^6 + 12*a*b^4*c - 48*a^2*b^2*c^2 + 64*a^3*c^3 + 32*b^3*c^2 - 128*a*b*c^3 + 256*c^4])
J = ideal([*I.gens(), statement])

exit()

R.<a,b,c,p> = PolynomialRing(QQ, 4)
P.<x> = PolynomialRing(R, 1)
duplication = (x^4 - 2*b*x**2 - 8*c*x + b**2 - 4*a*c) / (4 * (x**3 + a * x**2 + b * x + c))
poly = P(duplication(x = duplication).numerator())
poly = P(poly / poly.lc())
coeff = poly.coefficients()[15]
coeff = factor(coeff)[1][0]

def mod2(poly):
    result = 0
    for (c, m) in zip(poly.coefficients(), poly.monomials()):
        if c % 2 == 1:
            result += m
    return result

print(coeff)

print(mod2(coeff(b = 2*b + 1)))

print(mod2(coeff(b = 4*b + 2)/2**6)) # implies a, c odd
print(mod2(coeff(b = 4*b + 2, a = 2*a + 1, c = 2*c + 1)/2**8)) # impossible

print(mod2(coeff(b = 8*b + 4)/2**6)) # implies a or c even
print(mod2(coeff(b = 8*b + 4, a = 2 * a)/2**8)) # implies c even, so 4|c
print(mod2(coeff(b = 8*b + 4, c = 4 * c)/2**12)) # implies a, c/4 odd
print(mod2(coeff(b = 8*b + 4, c = 8 * c + 4, a = 2 * a + 1)/2**15))

exit()

print(mod2(coeff))
print(mod2(coeff(b = 2*b)/64))
# it follows that 2|b

# assume b/2 odd
print(mod2(coeff(b = 4*b + 2)/64)) # implies a, c odd
print(mod2(coeff(b = 4*b + 2, a = 2*a + 1, c = 2*c + 1)/256)) # contradiction
# it follows that 4|b !!!

print(mod2(coeff(b = 4*b)/64)) # implies 2|a or 2|c

# 1. case: 2|a
print(mod2(coeff(b = 4*b, a = 2*a)/256)) # implies 2|c
# so in any case 2|c => 4|c !!!
print(mod2(coeff(b = 4*b, c = 4*c)/4096))

# assume b/4 odd
print(mod2(coeff(b = 8*b + 4, c = 4*c)/4096)) # implies a, c/4 odd
print(mod2(coeff(b = 8*b + 4, c = 8*c + 4, a = 2*a + 1)/32768)) # implies (a-1)/2, (c-4)/8 both even or both odd
# 1. case: both odd
print(mod2(coeff(b = 8*b + 4, c = 16*c + 12, a = 4*a + 3)/65536)) # impossible
# 2. case: both even
print(mod2(coeff(b = 8*b + 4, c = 16*c + 4, a = 4*a + 1)/65536)) # impossible
# thus 8|b !!!

# we now have 8|b, 4|c
print(mod2(coeff(b = 8*b, c = 4*c)/2**12)) # implies 2|a or 2|(c/4)

# 1. case: 2|a
print(mod2(coeff(b = 8*b, c = 4*c, a = 2*a)/2**15)) # implies 4|a
print(mod2(coeff(b = 8*b, c = 4*c, a = 4*a)/2**16)) # implies 2|(c/4)
# so in any case 2|(c/4) => 16|c !!!

# we have now 8|b, 16|c
print(mod2(coeff(b = 8*b, c = 16*c)/2**18))

# assume b/8 odd
print(mod2(coeff(b = 16*b + 8, c = 16*c)/2**18)) # implies a, c/8 odd
print(mod2(coeff(b = 16*b + 8, c = 32*c + 16, a = 2*a + 1)/2**21)) # implies (a-1)/2, (c-16)/32 both even or both odd
# 1. case: both odd
print(mod2(coeff(b = 16*b + 8, c = 64*c + 48, a = 4*a + 3)/2**24))

exit()

coeff = coeff(b = 2*b)/64
print(coeff)
print()
# 3 cases now
# 1. 2|a & 2|b
coeff1 = coeff(b = 2*b, a = 2*a)/4 # implies 2|c, so last case
print(coeff1)
# 2. none is even
coeff3 = coeff(b = 2*b + 1, c = 2*c + 1, a = 2*a + 1)/4 # impossible - mod 2 this gives 1
print(coeff3)
# 3. 2|b & 2|c, so 4|c
print()
coeff = coeff(b = 2*b, c = 4*c)/64
print(coeff)
# 1. none is even
coeff1 = coeff(b = 2*b + 1, c = 2*c + 1, a = 2*a + 1)/8
print(coeff1)
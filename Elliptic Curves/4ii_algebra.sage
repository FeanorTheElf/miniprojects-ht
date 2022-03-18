
p1 = (-1, 1/2)
p2 = (1, 1/2)
p3 = (3, 3/2)

var("a1", "a2","a3","a4", "a6")

def eq(p):
    x, y = p
    return y**2 + a1 * x * y - x**3 - a2 * x**2 - a4 * x

print(eq(p1))
print(eq(p2))
print(eq(p3))

a1 = 8
a2 = 1/4
a3 = 0
a4 = 3
a6 = 0

E = EllipticCurve(QQ, [a1, a2, a3, a4, a6])
print(E)
print(E.rank())
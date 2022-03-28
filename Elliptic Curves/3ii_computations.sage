R.<u,r,s,t,v,w,x,y> = QQ[]

f = y^2 + x * y + v * y - x^3 - v * x^2
phix = u^2 * x + r
phiy = u^3 * y + u^2 * s * x + t
g = y^2 + x * y + w * y - x^3
g = g(x = phix, y = phiy)

h = g - u^6 * f
hx = [h(x = 0), *[h.coefficient(x^n) for n in range(1,5)]]
hxy = [*[z(y = 0) for z in hx], *[z.coefficient(y^n) for n in range(1,5) for z in hx]]

R2.<u,r,s,t,v,w> = QQ[]
I = R2.ideal(hxy)
J = I.radical()
print(I)
print(J.dimension())
print(J.elimination_ideal([u,r,s,t]))
print(J.primary_decomposition())
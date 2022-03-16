var("x", "y", "x1", "x2", "y1", "y2", "bx", "by", "l", "v", "a2", "a4", "a6")

sigma = -1
phix = x - bx
phiy = sigma * y + l * x - sigma * by - l * bx

m = (y1 - y2)/(x1 - x2)
strange = (v + 1)*m + m**2 - v - x1 - x2
weierstrass = -x1 - x2 + m**2 - a2
e1 = strange(x1 = phix(x = x1, y = y1), y1 = phiy(x = x1, y = y1), x2 = phix(x = x2, y = y2), y2 = phiy(x = x2, y = y2))
e2 = phix(x = weierstrass)

_phix = phix(x1 = 0, y1 = 1/2, x2 = 1, y2 = -1/2, l = 0, v = -1, bx = 0, by = 1/2, a2 = -1)
_phiy = phiy(x1 = 0, y1 = 1/2, x2 = 1, y2 = -1/2, l = 0, v = -1, bx = 0, by = 1/2, a2 = -1)
_e1 = e1(x1 = 0, y1 = 1/2, x2 = 1, y2 = -1/2, l = 0, v = -1, bx = 0, by = 1/2, a2 = -1)
_e2 = e2(x1 = 0, y1 = 1/2, x2 = 1, y2 = -1/2, l = 0, v = -1, bx = 0, by = 1/2, a2 = -1)

tangent = (3*x**2 + 2*a2*x + a4) / 2*y
dupl_x = tangent**2 - 2*x - a2
dupl_y = tangent * (x - dupl_x) - y
_v = bx - dupl_x(x = bx, y = by)
_l = (v**2  + sigma * (by - dupl_y(x = bx, y = by))) / v
evil = (e1(v = _v, l = _l) - e2(v = _v, l = _l)) * v**2 * (x1 - x2)
print(evil(l = 0, v = -1, bx = 0, by = 1/2, a2 = -1, a4 = 0, a6 = 1/4))
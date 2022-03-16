# (a, b, c) = (a_2, a_4, a_6),
# y = beta, 
# (u, v) = (alpha_2, beta_2)
R.<a,b,c,y,u,v> = PolynomialRing(QQ, 6)

# slope of the tangent at (0,y)
l1_num = b
l1_den = 2 * y
# slope of the tangent at (u,v)
l2_num = 3 * u^2 + 2 * a * u + b
l2_den = 2 * v

I = ideal(
    y^2 - c, # (0,y) in E
    v^2 - u^3 - a * u^2 - b * u - c, # (u,v) in E

    u * l1_den^2 + a * l1_den^2 - l1_num^2,
    v * l1_den + y * l1_den + u * l1_num, # [2](0,y) = (u,v)

    2 * u * l2_den^2 + a * l2_den^2 - l2_num^2,
    -y * l2_den + v * l2_den - u * l2_num, # [2](u,v) = (0,-y)
)

# the next statement prints:
# Ideal (u^3 + 4*y*v) of Multivariate Polynomial Ring ...
print(I.elimination_ideal([a, b, c]))

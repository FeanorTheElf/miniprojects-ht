
for a in range(10):
    for b in range(1,10):
        if a^2 - 4*b != 0:
            E = EllipticCurve([0, a, 0, b, 0])
            if E.rank() == 1:
                print(E)
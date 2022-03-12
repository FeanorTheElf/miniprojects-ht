from itertools import product

n = 5
F = GF(n)
non_square_residues = [2, 3]
A = Matrix(F, n, 3)
for i in range(n):
    for j in range(3):
        A[i, j] = F(i)**j
    
for rhs in product(*[non_square_residues for _ in range(n)]):
    rhs = vector(F, [rhs[i] - F(i)**3 for i in range(n)])
    try:
        print(A.solve_right(rhs))
    except ValueError:
        pass
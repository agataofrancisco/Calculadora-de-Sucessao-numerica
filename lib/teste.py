import sympy as sp

termos = []
termos = input("Digite os termos da sequência: ").split(',')
    
# Convercao os termos para inteiros
termos = [int(t.strip()) for t in termos]


#termo geral
r = termos[2] - termos[1]
a1 = termos[0]
n = sp.Symbol('n')
tg = a1 + (n-1)*r

print("o termo geral é:"+str(tg))

#Calcular uma posição específica
n_ = 20

termo_n = tg.subs(n, n_)

tg, termo_n
print(termo_n)
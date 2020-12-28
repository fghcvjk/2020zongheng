from sage.crypto.lwe import LWE
from sage.stats.distributions.discrete_gaussian_integer \
    import DiscreteGaussianDistributionIntegerSampler as DGDIS
import uuid

FLAG = 'flag{' + str(uuid.uuid4()) + '}'
FLAG = FLAG.encode().replace(b'-',b'')

assert FLAG.startswith(b'flag{') and FLAG.endswith(b'}')
s = list(FLAG[5:-1])

n = len(s)
q = random_prime(1<<512, proof=False, lbound=1<<511)

lwe = LWE(n=n, q=q, D=DGDIS(1<<128))
lwe._LWE__s = vector(Zmod(q), s)

L = [lwe() for _ in range(2*n)]

with open('task.txt', 'w') as f:
    _ = f.write(f"q = {q}\n")
    _ = f.write(f"L = {L}\n")

from Duffing import DuffingOscillator
from DoublePendulum import DoublePendulum
from ElasticPendulum import ElasticPendulum



def ElasticPendulumTests():
    t1 = ElasticPendulum(0.3, 0.03, 0.2, 0.01, 4.5, 4.2, 9.8, 9.8)
    t1.solve(100000, 0.01, 1)

def DoublePendulumTests():
    t1 = DoublePendulum(0.1, 0.03, 0.1, 0.02, 2.4, 2.2, 9.5, 9.1)
    t1.solve(10000, 0.01, 1)

def DuffingPendulumTests():
    t1 = DuffingOscillator(0.3, 0.01, 1, 5, 0.5, 8, 0.02)
    t1.solve(10000, 0.01, 1)

#ElasticPendulumTests()
DoublePendulumTests()
#DuffingPendulumTests()
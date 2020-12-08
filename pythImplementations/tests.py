import SimplePendulum as sp
from numerical_integration import euler_step


def SimplePendulumTests():

    SimplePend = sp.SimplePendellum(4.5, 0.2, 0.002, 0.1)
    SimplePend.solve(0.001, 10000)


SimplePendulumTests()
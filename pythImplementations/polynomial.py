#Alright let's fuck around with it

import matplotlib.pyplot as plt
import math
import numpy as np

class Polynomial:

    elements = []

    def __init__(self, degree):
        "Initializes an empty polynomial of degree n"
        
        self.degree = degree

        for i in range(degree):
            self.elements.append(0)
    
    def add_element(self, degree, val):
        self.elements[degree] = val        

    def get_coeff(self, degree):
        return self.elements[degree]
        
    def add(self, other):
    
        assert(other.__name__ == 'Polynomial')

        larger_degree = self.degree if(self.degree > other.degree) else other.degree
        smaller_degree = other.degree if(self.degree > other.degree) else self.degree
        t = self if (self.degree > other.degree) else other
        
        new_poly = Polynomial(larger_degree)
        for i in range(smaller_degree):
            new_poly.add_element(degree, (self.get_coeff(i) + other.get_coeff(i)))

        if(smaller_degree != larger_degree):
            for i in range(smaller_degree, larger_degree):
                new_poly.add_element(degree, t.get_coeff(i))
            
        return new_poly

    def isPolynomial(self):
        return True

    def apply(self, x):
        
        result = 0
        for i in range(degree):
            result += x^i * self.get_coeff()
        return result
    
    def plot(self):
        
        t = np.arange(-10,10,1)
        plotable = []
        for i in t:
            plotable.append(self.apply(t))
        
        plt.plot(plotable, t)
        plt.show()

t = Polynomial(5)

t.add_element(2, 1)
print(t.elements)

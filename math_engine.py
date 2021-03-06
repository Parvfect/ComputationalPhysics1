
#Alright let's fuck around with it

import matplotlib.pyplot as plt
import math
import numpy as np



class Matrix:
    """Representation of an n-dimensional linear transformation"""
    

    def __init__(self, dimensions, elements):
        self.dimensions = dimensions
        self.elements = elements
        self.arr = np.zeros((self.dimensions, self.dimensions))

        for i in range(dimensions) :
            for j in range(dimensions) :
                self.arr[i][j] = elements[i * (dimensions) + j]
            
        
    def equals(self, other):
        if self.dimensions != other.dimensions:
            return False
        
        for i in range(len(self.elements)):
            if self.elements[i] != other.elements[i]:
                return False

        return True
    
    def get_element(self,r, c):
        return self.arr[r][c]
    
    def get_row(self, i):
        return self.arr[i]
    
    def get_col(self, i):
        return [c[i] for c in self.arr]
        
    def copy(self):
        
        elements = []
        
        for i in range(0,self.dimensions):
            for j in range(0,self.dimensions):
                elements.append(self.arr[i][j]) 
            
        
        return Matrix(self.dimensions, elements)
    

    def multiply(self, other):
        
        assert (isinstance(other,Matrix))
        
        elements = []
        val = 0
        
        # Selecting sub row of first matrix
        for i in range(self.dimensions):
            sub_1 = self.get_row(i)

            # Selecting sub column of second matrix 
            for j in range(len(sub_1)):
                val = 0
                sub_2 = other.get_col(j)

                # Multiplying element by element in sub matrices
                for k in range(len(sub_1)):
                    val += sub_1[k] * sub_2[k]

                # Appeding to the resultant element list    
                elements.append(val)

        return Matrix(self.dimensions, elements)

    def modulus(self):

        for i in range(self.dimensions):
            t = self.sub_matrix(i+1,i+1, self.dimensions-1, self.dimensions-1)
            
        return

    def inverse(self):
        return

    def eigenvalues(self):
        return 

    def eigenvector(self):
        return
   


'''
class Matrix:
    

class Function:

class One_to_one_funciton:

class Multivariable_funciton:

class Field:

class Scalar_Field:
    
class VectorField:
'''



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
        for i in range(self.degree):
            result += math.pow(x,i) * self.get_coeff(i)
        return result
    
    def plot(self):
        
        t = np.arange(-100.0, 100.0, 0.001)
        plotable = []
        for i in t:
            plotable.append(self.apply(i))
        
        plt.plot(t, plotable)
        plt.show()

        
class functional_polynomial(Polynomial):
    
    def apply(self, x):
        result = 0
        for i in range(self.degree):
            f = self.get_coeff(i)
            result += f(math.pow(x,i))
        return result



def equals_elementwise(a,b):
    #assert a and b are lists

    if len(a)!= len(b) :
        return False

    for i in range(len(a)):
        if a[i] != b[i]:
            return False

    return True

def test_matrix_multiplication():
    t = Matrix(3,[1,2,3,4,5,6,7,8,9])
    s = Matrix(3,[1,2,3,4,5,6,7,8,9])
    p = t.multiply(s)
    res = Matrix(3, [30.0 ,  36.0,  42.0 , 66.0 , 81.0 ,  96.0, 102.0 , 126.0, 150.0])
    return res.equals(p)


print(test_matrix_multiplication())

import numpy as np

class ComplexNumber:
    
    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary
    
    def __repr__(self):
        return repr("{} + {}i".format(self.real, self.imaginary))

    def get_realPart(self):
        return self.real
    
    def get_imaginaryPart(self):
        return self.imaginary

    def conjugate(self):
        return ComplexNumber(self.real, -self.imaginary)
    
    def add(self, other):
        assert isinstance(other, ComplexNumber)
        return ComplexNumber(self.real+ other.real, self.imaginary+ other.imaginary)

    def multiply(self, other):
        if isinstance(other, ComplexNumber):
            return ComplexNumber((self.real*other.real - self.imaginary*other.imaginary), (self.real*other.imaginary + self.imaginary*other.real))
        else:
            return ComplexNumber(self.real*other, self.imaginary*other)    

class Vector:
    
    def __init__(self, dimensions, elements):
        self.dimensions = dimensions
        self.elements = elements

    def get_element(self, number):
        return self.elements[number]=

class ComplexVector:
    
    def __init__(self, dimensions, elements):
        super().__init__()

class Matrix:
    
    def __init__(self, dimensions, values):
        """Maps a one dimensional array to a matrix"""
        assert type(dimensions) == tuple
        self.dimensions = dimensions
        self.elements=np.zeros(shape = (self.dimensions))
        
        for i in range(dimensions[0]):
            for j in range(dimensions[1]):
                self.elements[i][j] = values[i*(dimensions[1])+j]    
    
    def get_element(self, r, c):
        return self.elements[r][c]        

    def dot_product(self, other):
        assert isinstance(other, Matrix)


    def modulus(self):
        
        return 
    
class ComplexMatrix(Matrix):
    
    def __init__(self, dimensions, values):
        super().__init__(self)
        for i in values:
            assert isinstance(i, ComplexNumber)

    def get_element(self, r, c):
        return self.elements[r][c]        


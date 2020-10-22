import numpy as np

class ComplexNumber:
    """A complex number representation"""    
   
    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary

    def __add__(self, other):
        """Uses + for operator overloading"""
        if isinstance(other, ComplexNumber):
            return ComplexNumber(self.real+ other.real, self.imaginary+ other.imaginary)
        else:
            return ComplexNumber(self.real + other, self.imaginary)
    
    def __sub__(self, other):
        """Uses - for operator overloading"""
        return self.__add__(ComplexNumber(-other.real, -other.imaginary))

    def __mul__(self, other):
        """Uses * for operator overloading"""
        if isinstance(other, ComplexNumber):
            return ComplexNumber((self.real*other.real + self.imaginary*other.imaginary), (self.real*other.imaginary + self.imaginary*other.real))
        else:
            return ComplexNumber(self.real*other, self.imaginary*other)    

    def __truediv__(self, other):
        """Uses / for operator overloading"""
        if isinstance(other, ComplexNumber):
            num = self.__mul__(other.conjugate())
            denom = other.real*other.real - other.imaginary*other.imaginary
            return ComplexNumber(num.real/denom, num.imaginary/denom)
        else:
            return ComplexNumber(self.real/other, self.imaginary/other)

    def __repr__(self):
        if self.imaginary == 0:
            return repr(self.real)
        return repr("{} + {}i".format(self.real, self.imaginary))

    def get_realPart(self):
        return self.real
    
    def get_imaginaryPart(self):
        return self.imaginary

    def conjugate(self):
        return ComplexNumber(self.real, -self.imaginary)
    
    
  
class Vector:
    """Representation of an n-dimensional vector"""
    def __init__(self, dimensions, elements):
        self.dimensions = dimensions
        self.elements = elements

    def get_element(self, number):
        return self.elements[number]

class ComplexVector:
    """Representation of a complex vector"""
    def __init__(self, dimensions, elements):
        super().__init__()
    

class Matrix:
    """Representation of an n-dimensional linear transformation"""
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

    def eigen(self):
        """Returns the eigenvector and eigenvalue of the greatest magnitude"""
        pass

    def modulus(self):
        """Takes the determinant of a matrix"""
        
        if self.dimensions[0] != self.dimensions[1]:
            print("Needs to be a square matrice")
            return 0 
        
        if self.dimensions == (2,2):
            return (self.get_element(0,0)*self.get_element(1,1)) - (self.get_element(1,0)*self.get_element(0,1))
        else:
            return 0
        return 
    
    def adj(self):
        """Returns the adjoint of a matrix"""
        pass

    def inverse(self):
        """Returns the inverse of a matrix"""
        pass

class ComplexMatrix(Matrix):
    """Representation of a matrix with complex values"""
    def __init__(self, dimensions, values):
        super().__init__(self)
        for i in values:
            assert isinstance(i, ComplexNumber)

    def get_element(self, r, c):
        return self.elements[r][c]        

class CartesianCoordinate:
    """Representation of a point"""
    def __init__(self, x = 0, y = 0 ,z = 0):
        self.x = x 
        self.y = y
        self.z = z


def LorentzForce(E, B, v, q):
    """Takes in the electric field strength, magnetic field strength and scalar
    charge and returns the lorentz force as a coordinate"""
    F = CartesianCoordinate()
    F.x = q*E.x + q*v.x*B.x
    F.y = q*E.y + q*v.y*B.y
    F.z = q*E.z + q*v.z*B.z
    return F
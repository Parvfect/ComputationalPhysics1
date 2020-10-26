import UIKit


struct ComplexNumber:CustomStringConvertible {
    //A complex number representation
    var real:Double
    var imaginary:Double
    var mod:Double
    var theta:Double
    
    init(real:Double, imaginary:Double){
        self.real = real
        self.imaginary = imaginary
        self.mod =  sqrt(self.real*self.real + self.imaginary*self.imaginary)
        self.theta = atan(self.imaginary/self.real)
    }
    
    var description: String {
        return "\(real) + \(imaginary)i"
    }
    
    func getImaginary() -> Double{
        return self.imaginary
    }
    
    func getReal() -> Double{
        return self.real
    }
    
    func conjugate() -> ComplexNumber{
        return ComplexNumber(real: self.real, imaginary: -self.imaginary)
    }
    
    func add(_ other: ComplexNumber) -> ComplexNumber{
        return ComplexNumber(real: (self.real+other.real), imaginary: (self.imaginary+other.imaginary))
    }
    
    func minus(_ other: ComplexNumber) -> ComplexNumber{
        return self.add(ComplexNumber(real: -other.real, imaginary: -other.imaginary))
    }
    
    func multiply(_ other: ComplexNumber) -> ComplexNumber{
        //Use varadic parameters to accept vary of input data types
        //return ComplexNumber(real: (self.real*(Double)other), imaginary: (self.imaginary*(Double)other))
        return ComplexNumber(real : (self.real*other.real - self.imaginary*other.imaginary), imaginary: (self.real*other.imaginary + other.real*self.imaginary))
    }
    
    func divide(_ other: ComplexNumber) -> ComplexNumber{
        let denom = other.real*other.real - other.imaginary*other.imaginary
        let num = self.multiply(other.conjugate())
        return ComplexNumber(real: num.real/denom, imaginary: num.imaginary/denom)
    }
 
    func polar_form() -> String {
        return "\(self.mod) ( cos\(self.theta) + isin\(self.theta))"
    }
    
    func eForm() -> String {
        return "\(self.mod)e^(i\(self.theta))"
    }


}

//var t = ComplexNumber(real:4, imaginary: 4)

class Vector{
    //Representation of a n-dimensional vector
    var dimensions:Int
    var elements:[Double]
    
    init(dimensions:Int, elements: [Double]){
        self.dimensions = dimensions
        self.elements = elements
    }
    
    func getElement(number:Int) -> Double{
        return self.elements[number]
    }
    
    func add(_ other: Vector) -> Vector{
        let s = Vector(dimensions: self.dimensions, elements: [])
        for i in 0..<self.elements.count {
            s.elements[i] = self.elements[i] + other.elements[i]
        }
        return s
    }

    func minus(_ other: Vector) -> Vector{
        let s = Vector(dimensions: self.dimensions, elements: [])
        for i in 0..<self.elements.count {
            s.elements[i] = self.elements[i] - other.elements[i]
        }
        return s
    }
    
}

/*class ComplexVector:Vector {
    
    init(dimensions:Int, elements: [ComplexNumber]){
        super.init(dimensions:dimensions, elements: elements)
    }
 //How do I Override the fricking elements array in ComplexVector? I hate swift
 
}*/

class Matrix{
    //Representation of an n-dimensional linear transformation
    var arr = [[Double]]()
    var dimensions:(x:Int, y:Int)
    
    init(dimensions:(x:Int, y:Int), elements:[Double]){
        self.dimensions = dimensions
        
        for i in 0...dimensions.x {
            for j in 0...dimensions.y{
                self.arr[i][j] = elements[i*dimensions.y + j]
            }
        }
    }
}
/* def get_element(self, r, c):
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
}*/



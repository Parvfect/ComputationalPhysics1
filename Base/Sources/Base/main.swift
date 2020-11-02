
import Foundation


infix operator **
//infix operator .

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
    
    func copy() -> ComplexNumber{
        return ComplexNumber(real: self.real, imaginary: self.imaginary)
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
    
    func subtract(_ other: ComplexNumber) -> ComplexNumber{
        return self.add(ComplexNumber(real: -other.real, imaginary: -other.imaginary))
    }
    
    func multiply(_ other: ComplexNumber) -> ComplexNumber{
        //Use varadic parameters to accept vary of input data types
        //return ComplexNumber(real: (self.real*(Double)other), imaginary: (self.imaginary*(Double)other))
        //Needs to be fixed, causing problems
        return ComplexNumber(real : (self.real*other.real - self.imaginary*other.imaginary), imaginary: (self.real*other.imaginary + other.real*self.imaginary))
    }
    
    func power(_ other: Int) -> ComplexNumber{
        var s = self.copy()
        let t = self.copy()
        var i = 1
        while i < other {
            s = t*s
            i+=1
        }
        return s
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
    
    func infSeq(){
        var t = self.copy()
        let s = ComplexNumber(real:1, imaginary:0)
        for i in 0...100{
            t = ComplexNumber(real: t.real * t.real - t.imaginary * t.imaginary, imaginary: 2*t.real*t.imaginary) + s
            print(t)
            if (t.real * t.real + t.imaginary * t.imaginary) >= 4 {
                return i
            }
        }
    }
}

var t = ComplexNumber(real:0, imaginary:0)
t.infSeq()

extension ComplexNumber{
    //Verified, that is how operator overloading works (well one way)
    static func + (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.add(right)
    }
    static func - (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.subtract(right)
    }
    static func * (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.multiply(right)
    }
    static func / (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.divide(right)
    }
    static func ** (left: ComplexNumber, right:Int) -> ComplexNumber{
        return left.power(right)
    }
    
}

//var t = ComplexNumber(real:4, imaginary: 4)

struct Vector{
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
        var s = Vector(dimensions: self.dimensions, elements: [])
        for i in 0..<self.elements.count {
            s.elements[i] = self.elements[i] + other.elements[i]
        }
        return s
    }
    
    func minus(_ other: Vector) -> Vector{
        var s = Vector(dimensions: self.dimensions, elements: [])
        for i in 0..<self.elements.count {
            s.elements[i] = self.elements[i] - other.elements[i]
        }
        return s
    }
    
    func multiply(_ other: Double) -> Vector{
        var s = Vector(dimensions: self.dimensions, elements: [])
        for i in 0..<self.elements.count {
            s.elements[i] = self.elements[i] * other
        }
        return s
    }
    
    func dotProduct(_ other:Vector) -> Double{
        var sum = 0.0
        for i in 0..<self.elements.count {
            sum += self.elements[i] + other.elements[i]
        }
        return sum
    }
}

extension Vector{
    static func + (left: Vector, right:Vector) -> Vector{
        return left.add(right)
    }
    static func - (left: Vector, right:Vector) -> Vector{
        return left.minus(right)
    }
    static func *(left: Vector, right:Double) -> Vector{
        return left.multiply(right)
    }
    /*static func .(left: Vector, right:Vector) -> Double{
     return left.dotProduct(right)
     }*/
}

struct ComplexVector {
    //A vector but its complex. Inheritance was just too complicated
    
    var arr:[ComplexNumber]
    var dimensions:Int
    
    init(dimensions:Int, real_elements: [Double], imag_elements: [Double]){
        self.dimensions = dimensions
        self.arr = []
        for i in 0...real_elements.count-1 {
            self.arr.append(ComplexNumber(real:real_elements[i], imaginary: imag_elements[i]))
        }
    }
    
    func getElement(number:Int) -> ComplexNumber{
        return self.arr[number]
    }
    
    func add(_ other: ComplexVector) -> ComplexVector{
        var s = ComplexVector(dimensions: self.dimensions, real_elements: [], imag_elements: [])
        for i in 0..<self.arr.count-1 {
            s.arr[i] = self.arr[i] + other.arr[i]
        }
        return s
    }
    
    func minus(_ other: ComplexVector) -> ComplexVector{
        var s = ComplexVector(dimensions: self.dimensions, real_elements: [], imag_elements: [])
        for i in 0..<self.arr.count-1 {
            s.arr[i] = self.arr[i] - other.arr[i]
        }
        return s
    }
    
    
    func divide(_ other: ComplexVector) -> ComplexVector{
        var s = ComplexVector(dimensions: self.dimensions, real_elements: [], imag_elements: [])
        for i in 0..<self.arr.count-1 {
            s.arr[i] = self.arr[i] / other.arr[i]
        }
        return s
    }
    
    func multiply(_ other: ComplexVector) -> ComplexVector{
        var s = ComplexVector(dimensions: self.dimensions, real_elements: [], imag_elements: [])
        for i in 0..<self.arr.count-1 {
            s.arr[i] = self.arr[i] * other.arr[i]
        }
        return s
    }
    
    
    
}

struct Matrix{
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

struct CartesianCoordinate{
    //Representation of a point
    var x:Double
    var y:Double
    var z:Double
    init(x:Double, y:Double ,z:Double){
        self.x = x
        self.y = y
        self.z = z
    }
}

var t = ComplexNumber(real:3, imaginary: 1)
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
 
 
 
 def LorentzForce(E, B, v, q):
 """Takes in the electric field strength, magnetic field strength and scalar
 charge and returns the lorentz force as a coordinate"""
 F = CartesianCoordinate()
 F.x = q*E.x + q*v.x*B.x
 F.y = q*E.y + q*v.y*B.y
 F.z = q*E.z + q*v.z*B.z
 return F
 }*/


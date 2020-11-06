
import Foundation

/*
What I would like to add in this-- 

1) Some special linear transformations and vectors, so that I don't have to enter them every time
2) Better Documentation
3) Handling for all kinds of operator overloading, not just one side
4) A struct for an expression, or is that just a function..?
5) Vector struct's directionality
6) A mapping feature -- need to figure out how to make graphs on swift
7) . dot product operator overloading??
8) Seperate files for special functions, classes, matrices, vectors, expressions

*/


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
    
    func infSeq() -> Int{
        var t = self.copy()
        let s = ComplexNumber(real:1, imaginary:0)
        for i in 0...100{
            t = ComplexNumber(real: t.real * t.real - t.imaginary * t.imaginary, imaginary: 2*t.real*t.imaginary) + s
            print(t)
            if (t.real * t.real + t.imaginary * t.imaginary) >= 4 {
                return i
            }
        }
        return 0
    }
}


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


struct Vector{
    //Representation of a n-dimensional vector
    var dimensions:Int
    var elements:[Double]
    
    init(dimensions:Int, elements: [Double]){
        self.dimensions = dimensions
        self.elements = elements
    }
    
    func get_element(p:Int) -> Double{
        return self.elements[number]
    }

    func add_element(t:Double) {
        self.elements.append(t)
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

    func transform(_ other:Matrix) -> Vector{
        if self.dimesions!= other.dimesions.0{
            print("Can't be multiplied with each other you dolt")
        }
        let t = Vector(dimensions:self.dimensions, elements:[])
        var value = 0.0
        else{
            for i in 0...self.dimesions{
                for j in 0...self.dimensions{
                    value += other.get_element(r:i,c:j) * self.get_element(p:j)
                }
                t.add_element(value)
            }
        }
        return t

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
    static func *(left:Matrix, right:Vector) -> Vector{
        return right.transform(left)
    }

    static func *(left:Vector, right:Matrix) -> Vector{
        return left.transform(right)
    }
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

    func get_element(r:Int, c:Int) -> Double {
        return self.arr[r][c]
    }

    func copy() -> Matrix{
        var elements: [Double]
        for i in 0...dimensions.x {
            for j in 0...dimensions.y{
                elements.append(self.arr[i][j]) 
            }
        }
        return Matrix(dimensions:self.diimensions, elements:elements)
    }

    func modulus(A:[[Double]] = [[]], total:Double = 0.0) -> Double {

        let indices = self.dimensions.0
        if self.dimensions.0 == self.dimensions.1{
            if self.dimensions.0 == 2{
                return (self.get_element(r:0,c:0) * self.get_element(r:1,c:1) - self.get_element(r:1,c:0) * self.get_element(r:0,c:1))
            }
            //Recursively creating smaller matrices to calcluate their determinant
            else{

                for fc in 0..(indices){
                    As = self.copy()
                    As = As[1:]
                    height = len(As)

                    for i in 0..height{
                        As[i] = As[i][0:fc] + As[i][fc+1:] 
                    }
                            sign = (-1) ** (fc % 2) # F) 
                    # G) pass submatrix recursively
                    sub_det = modulus(As)
                    # H) total all returns from recursion
                    total += sign * A[0][fc] * sub_det 
            
                return total
                }
                

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

import Foundation;
infix operator **;

public struct ComplexNumber: isNumber {
    
    public var real:Double
    public var imaginary:Double
    public var mod:Double
    public var theta:Double
    
    
    public init(real:Double, imaginary:Double){
        self.real = real
        self.imaginary = imaginary
        self.mod =  sqrt(self.real*self.real + self.imaginary*self.imaginary)
        self.theta = atan(self.imaginary/self.real)
        
    }
    
    func copy() -> ComplexNumber{
        return ComplexNumber(real: self.real, imaginary: self.imaginary)
    }
    
    public var description: String {
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
        //Use public varadic parameters to accept public vary of input data types
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
    public static func + (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.add(right)
    }
    public static func - (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.subtract(right)
    }
    public static func * (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.multiply(right)
    }
    public static func / (left: ComplexNumber, right:ComplexNumber) -> ComplexNumber{
        return left.divide(right)
    }
    public static func ** (left: ComplexNumber, right:Int) -> ComplexNumber{
        return left.power(right)
    }
    
}

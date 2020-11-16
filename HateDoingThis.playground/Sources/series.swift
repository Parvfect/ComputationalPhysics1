import Foundation


public struct ArithmeticProgression:CustomStringConvertible{
    var a:Double
    var d:Double
    var n:Double

    init(a:Double, d:Double, n:Double){
        self.a = a
        self.d = d
        self.n = n
    }

    func getLastTerm()-> Double{
        return (self.a + (self.n-1)*self.d)
    }

    func sum() -> Double{
        return (self.n/2)*(2*self.a + (self.n-1)*self.d)
    }

    func sum_to_k(k:Double) -> Double{
        return (k/2)*(2*self.a + (k-1)*self.d)
    }

    public var description: String{
        return "\(self.a) + \(self.sum_to_k(k:2.0)) + \(self.sum_to_k(k:3.0)) + \(self.sum_to_k(k:4.0)) + ... + \(self.getLastTerm())"
    }
}


public struct GeometricProgression:CustomStringConvertible{
    var a:Double
    var r:Double
    var n:Double

    init(a:Double, r:Double, n:Double){
        self.a = a
        self.r = r
        self.n = n
    }

    func getLastTerm()-> Double{
        return (self.a * pow(self.r,(self.n-1)))
    }

    func sum() -> Double{
        return (self.a*(1 - pow(self.r, (self.n-1))))/(1-self.r)
    }

    func sum_to_k(k:Double) -> Double{
        return (self.a*(1 - pow(self.r, (k-1))))/(1-self.r)
    }

    public var description: String{
        return "\(self.a) + \(self.sum_to_k(k:2.0)) + \(self.sum_to_k(k:3.0)) + \(self.sum_to_k(k:4.0)) + ... + \(self.getLastTerm())"
    }
}

public struct ArithoGeometricProgression:CustomStringConvertible{
    var a:Double
    var r:Double
    var n:Double
    var d:Double

    init(a:Double, r:Double, n:Double, d:Double){
        self.a = a
        self.r = r
        self.n = n
        self.d = d
    }

    func getLastTerm()-> Double{
        return ((self.a + (n-1)*self.d) * pow(self.r,(self.n-1)))
    }

    func sum() -> Double{
        return ((self.a - self.getLastTerm()*self.r) / (1-r)) + ((self.r*self.d*(1 - pow(self.r,(self.n-1))))/pow((1-self.r),2))
    }

    func sum_to_k(k:Double) -> Double{
            return ((self.a - self.getLastTerm()*self.r) / (1-r)) + ((self.r*self.d*(1 - pow(self.r,(k-1))))/pow((1-self.r),2))
    }

    public var description: String{
        return "\(self.a) + \(self.sum_to_k(k:2.0)) + \(self.sum_to_k(k:3.0)) + \(self.sum_to_k(k:4.0)) + ... + \(self.getLastTerm())"
    }
}

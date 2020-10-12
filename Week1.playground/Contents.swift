import UIKit
//Declaring Variables - Swift infers types and accepts type

let one = 1 //let is a constant, its value cannot be changed - analogous to final
let pi = Double.pi
var x = 1.0

var seconds = 2 //Infers type as int
var secondsDouble = 2.0
var secondsCastAsDouble = Double(seconds) //Typecasting

let implicitInt = 1
let explicit: Int = 1 //explicitly makes swift choose int as the data type

//This is a comment
/*This is a
 multiline comment*/


//Q1 - 2
func add(x:Int ,y : Int) ->Int {
    return (x+y)
}
//Q3
func cube(x:Double) -> Int{
    return Int((pow(x,3)))
}

//Parametric variables are immutable
//Q4
func factorial(x:Int) -> Int{
    var fact = 1
    var temp = x
    while(temp != 0){
        fact = fact * temp
        temp = temp-1
    }
    return fact
}

//Q5
public struct ComplexNumber:ArgandDiagramable {
    
    public private(set) var real: Double
    public private(set) var imaginary: Double
    
    //String interpretable
    public func repr() -> String{
        let representation = String(real) + " + i" + String(imaginary)
        return representation
    }
    
    public func getImagValue()->Double{
        return self.imaginary
    }
    
    public func getRealValue()->Double{
        return self.real
    }
    
    public func times(_ other: ComplexNumber) -> ComplexNumber{
        return ComplexNumber(
            real:(other.real*real - imaginary*other.imaginary),
            imaginary:(other.imaginary*real + imaginary*other.real)
        )
    }
    
    public func add(_ other: ComplexNumber) -> ComplexNumber{
        return ComplexNumber(
            real:(real+other.real),
            imaginary: (imaginary+other.imaginary)
        )
    }
    public func minus(_ other: ComplexNumber) -> ComplexNumber{
        return ComplexNumber(
            real:(real-other.real),
            imaginary: (imaginary-other.imaginary)
        )
    }
}
//So structs can be passed around like variables

var t = ComplexNumber(real:3, imaginary:4)
var n = ArgandDiagram(t)
//Q9

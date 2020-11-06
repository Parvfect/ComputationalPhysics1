
import Foundation




struct Function{
    //Okay I am a bit torn here. Do I make an init that makes an argument and the other thing as a function of specific arguments, or what..?
    //So maybe a list of arguments (dictionary), and their result is saved as the relation?
    var arguments:[String:Double]
    var result: Double

    init(result:Expression, arguments:[String: Double]){
        self.arguments = arguments
        self.result = result
    }
    func square_a_function(function: (Double) -> Double, argument: Double) -> Double {
        let x = function(argument)
        return x*x
    }

    func cube(x:Double) -> Double{
        return x*x*x
    }


    func x_then_y(x:(Double) -> Double, y:(Double)->Double, z:Double) -> Double{
        return x(y(z))
        
    }


    func exponent(number:Double, power:Int) -> Double{
        
        var sum = 1.0
        for _ in 1...power{
            sum *= number
        }
        return sum
    }

    func differentiate(function: (Double) -> Double, argument:Double) -> Double{
    //Change in function value for x and small change in x vs small change
    let delta = 0.000000001
    let change = function(argument+delta) - function(argument)
    return change/delta
    }

    func five_point_derivative(function: (Double) -> Double, argument: Double) -> Double{
        let delta = 0.000000001
        let change = 8*function(argument + delta) - 8*function(argument - delta) + function(argument - 2*delta) - function(argument + 2*delta)
        return change/(12*delta)
    }

    func integrate(function: (Double) -> Double, lower:Double, higher:Double, steps:Int) -> Double{
        
        var sum:Double = 0.0
        let delta = 0.00001
        var y0 = lower
        sum = 0.5*0.5*y0*function(higher)
        
        for _ in 0...steps{
            y0 += function(y0 + delta)
            sum += y0
        }
        return sum
    }

}







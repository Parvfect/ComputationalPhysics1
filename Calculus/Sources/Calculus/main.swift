
import Foundation

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
var t = differentiate(function:cube, argument:300.0)
var s = five_point_derivative(function:cube, argument:300.0)
var n = integrate(function:cos, lower:0.0, higher:343.0, steps:10000)

print(t)
print(s)
print(n)

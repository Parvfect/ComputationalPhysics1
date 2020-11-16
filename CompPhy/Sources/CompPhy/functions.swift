
import Foundation

//The idea is to take in a string and break it down into a computer readable and appliable expression

public struct Expression{
    public var arguments: [String:Double]
    public var coefficents: [Double]

}

public struct Function{
    //Okay I am a bit torn here. Do I make an init that makes an argument and the other thing as a function of specific arguments, or what..?
    //So maybe a list of arguments (dictionary), and their result is saved as the relation?
    //This is a one variable function
    //var arguments:[String:Double]
    //var result: Double

    /*init(result:Expression, arguments:[String: Double]){
        self.arguments = arguments
        self.result = result
    }*/

    var expression:String


    /*func apply(x:Double) -> Double{
        return expression(arguments)

    }*/
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

   /* func euler_step(function: (Double, Double) -> Double, x:Double, h:Double, y0:Double, steps:Int, time:t) -> Double{
        //yn+1 = yn + hf(t,y)
        
        for i in 0...steps{
            t+=h
            y0 += h * function(t, y0)
        }

        return y0
        
    }
*/
}


public func euler_step(function: (Double) -> Double, h:Double, y0:Double, steps:Int) -> Double{
        //yn+1 = yn + hf(t,y)
        
        var y = y0
        var value = 0.0
        for _ in 0...steps{
            y+=h
            value += h * function(y)
            print(y, value)
        }

        return value
        
    }


public func square(x:Double)->Double{
    return x*x
}



public func TrapezoidalIntegration(function:(Double)->Double, x:Double, n:Double, upper:Double)->Double{
    
    var x_temp = x
    
    /**Divide the range into trapeziums of height delta*/
    let delta = (upper - x)/(n)
    
    var i = 1.0
    
    /**Getting the first value y(0) - it won't be doubled as its the boundary*/
    var t:Double = function(x)
    
    while i<n{
        
        /**Moving x to the next point*/
        x_temp = x + delta * i
        
        /**Getting the y value for the point*/
        t += 2*function(x_temp)
        
        /**Shifting to the next trapezium*/
        i += 1.0
    }
    
    /**Getting the last value y(n) - it won't be doubled as its the boundary*/
    t += function(upper)
    
    return t*delta/2
}

public func SimpsonIntegration(function:(Double)->Double, x:Double, n:Double, upper:Double)->Double{

    var x_temp = x
    

    /**Divide the range into trapeziums of height delta*/
    let delta = (upper - x)/(n)
    
    var i = 1.0
    
    /**Getting the first value y(0) - it won't be doubled as its the boundary*/
    var t:Double = function(x)
    
    while i<n{
        
        /**Moving xs to the next point*/
        x_temp = x + delta * i

        /**Which is the better method? if else or force?*/
        if i.remainder(dividingBy:2) == 0.0{
            t += 2*function(x_temp)
        }
        else{
            t += 4*function(x_temp)
        }
       
        /**Shifting to the next curve*/
        i += 1.0
    }
    
    /**Getting the last value y(n) - it won't be doubled as its the boundary*/
    t += function(upper)
    
    return t*delta/3
}

/*
func expression(value:String){

    var arguments:[Character] = []
    var coefficents:[Character] = []
    var powers:[Character] = []
    var signs: [Character] = []
    var isPower:Bool = false
    for (index,val) in value.enumerated(){
        if val.isWhitespace{
            continue
        }
        if isPower{
            powers.append(val)
            isPower = false
            continue
        }
        if val.isNumber{
            if value[index+1].isNumber{
                while s.isNumber{
                    s = value[index+1]
                    index+=1
                    spcval += s
            }
            coefficents.append(val)
        }
        else if val.isMathSymbol{
            if val == "^"{
                isPower = true
                continue
                
            }
            signs.append(val)
        }
        else{
            arguments.append(val)
        }   
    }

    print(arguments)
    print(coefficents)
    print(powers)
    print(signs)
}*/

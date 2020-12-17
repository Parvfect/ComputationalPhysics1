import UIKit


/** Getting the values for two initial conditions */
var elasticPend = ElasticPendulumTests()
var doublePend = DoublePendulumTests()
var duffingOsc = DuffingOscialltorTests()

public func display_values(arr:([Double], [Double], [Double], [Double])){

    print("x1")
    for i in arr.0{
        print(i)
    }
    
    print("x2")
    for i in arr.1{
        print(i)
    }
    
    print("y1")
    for i in arr.2{
        print(i)
    }
    
    print("y2")
    for i in arr.3{
        print(i)
    }
    
}

//For Duffing oscillator
public func display_values(arr: ([Double], [Double])){
    
    print("x1")
    for i in arr.0{
        print(i)
    }
    
    print("y1")
    for i in arr.1{
        print(i)
    }
    
}

/** Displaying the values to be copied and analysed */

print("Elastic Pendulum 1")
display_values(arr: elasticPend.0)

print("Elastic Pendulum 2")
display_values(arr: elasticPend.1)

 

print("Double Pendulum 1")
display_values(arr: doublePend.0)

print("Double Pendulum 2")
display_values(arr: doublePend.1)



print("Duffing Oscillator 1")
display_values(arr: duffingOsc.0)

print("Duffing Oscillator 2")
display_values(arr: duffingOsc.1)


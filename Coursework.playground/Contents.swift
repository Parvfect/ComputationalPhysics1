import UIKit

var elasticPend = ElasticPendulumTests()
var doublePend = DoublePendulumTests()
//var duffingOsc = DuffingOscialltorTests()

public func display_values(arr:([Double], [Double], [Double], [Double])){

    for i in arr.0{
        print(i)
    }
    
    for i in arr.1{
        print(i)
    }
    
    for i in arr.2{
        print(i)
    }
    
    for i in arr.3{
        print(i)
    }
    
}

display_values(arr: elasticPend.0)
display_values(arr: elasticPend.1)

display_values(arr: doublePend.0)
display_values(arr: doublePend.1)

/**
display_values(arr: duffingOsc.0)
display_values(arr: duffingOsc.1)
*/

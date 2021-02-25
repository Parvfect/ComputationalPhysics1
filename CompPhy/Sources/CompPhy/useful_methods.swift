import Foundation


/** Operator overloading to make arrays more useable */

func +(left: Double, right:[Double]) -> ([Double]){
    var t:[Double] = []
    for i in 0...right.count-1{
        t.append(left * right[i])
    }
    
    return t
}

func -(left:[Double], right:[Double]) -> [Double]{
    
    var t:[Double] = []
    for i in 0...left.count-1{
        t.append(abs(left[i] - right[i]))
    }
    
    return t
}

func *(left: [Double], right:[Double]) -> ([Double]){
    
    var t:[Double] = []
    for i in 0...left.count-1{
        t.append(left[i] * right[i])
    }
    return t
}

func *(left: Double, right:[Double]) -> ([Double]){
    
    var t:[Double] = []
    for i in 0...right.count-1{
        t.append(left * right[i])
    }
    return t
}

func *(left: [Double], right:Double) -> ([Double]){
    
   return right * left
}


func +(left: [Double], right:[Double]) -> ([Double]){
    
    var t:[Double] = []
    for i in 0...left.count-1{
        t.append(left[i] + right[i])
    }
    return t
}

func -(left: Double, right:[Double]) -> ([Double]) {
    
    return ((-left) + right)
}

func /(left: [Double], right:Double) -> ([Double]){
    
    var t:[Double] = []
    for i in 0...left.count-1{
        t.append(left[i] / right)
    }
    return t
}

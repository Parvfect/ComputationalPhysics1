import UIKit

//Q1

var counter = 0
var looper = 0
while (counter<10){
    if looper%2 != 0{
        print(looper)
        counter+=1
    }
    looper+=1
}

//Q2&&3
func WeirdSum(n:Int)->Decimal{
   var sum:Decimal = 0.0
    for i in 1...n{
        sum += pow(-1,i)/(Decimal)((2*i)-1)
    }
   return 4*sum
}
//The sum converges to pi

//Q4
func RecursiveSum(n:Int)->Decimal{
    if n == 0{
        return 0.0
    }
    else{
        return pow(-1,n)/(Decimal)((2*n)-1)+RecursiveSum(n:(n-1))
    }
}


//Q5q

//Q6

struct DoubleVector{
    var dimensions:Int
    var elements :[Int]
    
    func sum(_ other:DoubleVector)->DoubleVector{
        var new_elements:[Int] = []
        for i in 0...self.elements.count-1{
            print(i)
            new_elements.append(other.elements[i]+self.elements[i])
        }
        return DoubleVector(dimensions:new_elements.count, elements:new_elements)
    }
    
    func scale(a:Int)->DoubleVector{
        var new_elements:[Int] = []
        for i in 0...self.elements.count-1{
            new_elements.append(a*self.elements[i])
        }
        return DoubleVector(dimensions:new_elements.count, elements:new_elements)
    }
    
}

var t = DoubleVector(dimensions: 3, elements: [2,3,4])
var s = DoubleVector(dimensions:3, elements: [3,4,5])


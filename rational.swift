//
//  rational.swift
//  
//
//  Created by (s) Parv Agarwal on 05/10/2020.
//
/*In Swift, both classes and structs can have properties and functions. The key difference is structs are value types and classes are reference types. Because of this, let and var behave differently with structs and classes.*/
 import Foundation

public struct RationalNumber{
    //You could add set to internal property to make them not settable from outside your module.
    public private(set) var numerator : Int
    public private(set) var demominator : Int
    
    
}

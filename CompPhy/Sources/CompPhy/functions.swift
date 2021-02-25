
/** 
Math philosophy is cool 
What does essentially continuous mean? In that sense, if it a characteristic of a function, what about stuff 
like differentiation and integration - are they in a sense, low level enough or are they higher type of functions?
*/

/** How would I define a functionable thing? What does that mean - on what can a function be applied?*/


public protocol isFunction{
    /** Tight mathematical bound to what a function is - useful for running higher integrable methods that have 
    strict dependencies */
    var isContinuous;
    var isDifferentiable;
    var isDiscrete;
    
    static func transform<T:FunctionableThing>(x:T) -> T
}

public protocol isfunction{
    /** Looser definition of a function - no added specific characteristics */

    static func transform<T:FunctionableThing>(x:T) -> T
}

public struct 

public struct square:isfunction{
    static func transform<T:FunctionableThing>(x:T) -> T{
        return (x*x)
    }
}


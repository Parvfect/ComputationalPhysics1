
public protocol Addable{
    static func +(left : Self, right : Self) -> Self
}

public protocol Subtractable{
    static func -(left : Self, right : Self) -> Self
}

public protocol Dividable{
    static func +(left : Self, right : Self) -> Self
}

public protocol Multipliable{
    static func +(left : Self, right : Self) -> Self
}

public protocol Comparable{
    public func equals(left: Self, right: Self) -> Self
}

/** Higher level protocols */

public protocol isNumber: Addable, Subtractable, Dividable, Multipliable{

}
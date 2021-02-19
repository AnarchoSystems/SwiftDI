//
//  Monoid.swift
//  
//
//  Created by Markus Pfeifer on 19.02.21.
//

import Foundation


public extension DIParticipant {
    
    ///Joins the constructed objects using monoid composition.
    /// - Parameters:
    ///     - other: Another DIParticipant constructing an element of a monoid.
    func compose<Other : DIParticipant>(with other: Other) -> ComposedDI<Self, Other, Implementation> where Other.Implementation == Implementation, Implementation : Monoid {
        compose(with: other, <>)
    }
    
}


public extension DIBuilder {
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant>
    (_ lhs: DI1,
     _ rhs: DI2)
    -> ComposedDI<DI1, DI2, DI1.Implementation>
    
    where DI1.Implementation == DI2.Implementation, DI1.Implementation : Monoid
    {
        lhs
            .compose(with: rhs)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3)
    -> ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant,
                           DI4 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3,
     _ fourth: DI4)
    -> ComposedDI<ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>, DI4, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation == DI4.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
            .compose(with: fourth)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant,
                           DI4 : DIParticipant,
                           DI5 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3,
     _ fourth: DI4,
     _ fifth: DI5)
    -> ComposedDI<ComposedDI<ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>, DI4, DI1.Implementation>, DI5, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation == DI4.Implementation, DI1.Implementation == DI5.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
            .compose(with: fourth)
            .compose(with: fifth)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant,
                           DI4 : DIParticipant,
                           DI5 : DIParticipant,
                           DI6 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3,
     _ fourth: DI4,
     _ fifth: DI5,
     _ sixth: DI6)
    -> ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>, DI4, DI1.Implementation>, DI5, DI1.Implementation>, DI6, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation == DI4.Implementation, DI1.Implementation == DI5.Implementation, DI6.Implementation == DI1.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
            .compose(with: fourth)
            .compose(with: fifth)
            .compose(with: sixth)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant,
                           DI4 : DIParticipant,
                           DI5 : DIParticipant,
                           DI6 : DIParticipant,
                           DI7 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3,
     _ fourth: DI4,
     _ fifth: DI5,
     _ sixth: DI6,
     _ seventh: DI7)
    -> ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>, DI4, DI1.Implementation>, DI5, DI1.Implementation>, DI6, DI1.Implementation>, DI7, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation == DI4.Implementation, DI1.Implementation == DI5.Implementation, DI6.Implementation == DI1.Implementation, DI1.Implementation == DI7.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
            .compose(with: fourth)
            .compose(with: fifth)
            .compose(with: sixth)
            .compose(with: seventh)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant,
                           DI4 : DIParticipant,
                           DI5 : DIParticipant,
                           DI6 : DIParticipant,
                           DI7 : DIParticipant,
                           DI8 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3,
     _ fourth: DI4,
     _ fifth: DI5,
     _ sixth: DI6,
     _ seventh: DI7,
     _ eighth: DI8)
    -> ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>, DI4, DI1.Implementation>, DI5, DI1.Implementation>, DI6, DI1.Implementation>, DI7, DI1.Implementation>, DI8, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation == DI4.Implementation, DI1.Implementation == DI5.Implementation, DI6.Implementation == DI1.Implementation, DI1.Implementation == DI7.Implementation, DI8.Implementation == DI1.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
            .compose(with: fourth)
            .compose(with: fifth)
            .compose(with: sixth)
            .compose(with: seventh)
            .compose(with: eighth)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant,
                           DI4 : DIParticipant,
                           DI5 : DIParticipant,
                           DI6 : DIParticipant,
                           DI7 : DIParticipant,
                           DI8 : DIParticipant,
                           DI9 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3,
     _ fourth: DI4,
     _ fifth: DI5,
     _ sixth: DI6,
     _ seventh: DI7,
     _ eighth: DI8,
     _ ninth: DI9)
    -> ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>, DI4, DI1.Implementation>, DI5, DI1.Implementation>, DI6, DI1.Implementation>, DI7, DI1.Implementation>, DI8, DI1.Implementation>, DI9, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation == DI4.Implementation, DI1.Implementation == DI5.Implementation, DI6.Implementation == DI1.Implementation, DI1.Implementation == DI7.Implementation, DI8.Implementation == DI1.Implementation, DI9.Implementation == DI1.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
            .compose(with: fourth)
            .compose(with: fifth)
            .compose(with: sixth)
            .compose(with: seventh)
            .compose(with: eighth)
            .compose(with: ninth)
    }
    
    static func buildBlock<DI1 : DIParticipant,
                           DI2 : DIParticipant,
                           DI3 : DIParticipant,
                           DI4 : DIParticipant,
                           DI5 : DIParticipant,
                           DI6 : DIParticipant,
                           DI7 : DIParticipant,
                           DI8 : DIParticipant,
                           DI9 : DIParticipant,
                           DI10 : DIParticipant>
    (_ first: DI1,
     _ second: DI2,
     _ third: DI3,
     _ fourth: DI4,
     _ fifth: DI5,
     _ sixth: DI6,
     _ seventh: DI7,
     _ eighth: DI8,
     _ ninth: DI9,
     _ tenth: DI10)
    -> ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<ComposedDI<DI1, DI2, DI1.Implementation>, DI3, DI1.Implementation>, DI4, DI1.Implementation>, DI5, DI1.Implementation>, DI6, DI1.Implementation>, DI7, DI1.Implementation>, DI8, DI1.Implementation>, DI9, DI1.Implementation>, DI10, DI1.Implementation>
    where DI1.Implementation == DI2.Implementation, DI1.Implementation == DI3.Implementation, DI1.Implementation == DI4.Implementation, DI1.Implementation == DI5.Implementation, DI6.Implementation == DI1.Implementation, DI1.Implementation == DI7.Implementation, DI8.Implementation == DI1.Implementation, DI9.Implementation == DI1.Implementation, DI10.Implementation == DI1.Implementation, DI1.Implementation : Monoid
    {
        first
            .compose(with: second)
            .compose(with: third)
            .compose(with: fourth)
            .compose(with: fifth)
            .compose(with: sixth)
            .compose(with: seventh)
            .compose(with: eighth)
            .compose(with: ninth)
            .compose(with: tenth)
    }
    
    static func buildBlock<DI : DIParticipant>(_ first: DI,
                                               _ second: DI,
                                               _ third: DI,
                                               _ fourth: DI,
                                               _ fifth: DI,
                                               _ sixth: DI,
                                               _ seventh: DI,
                                               _ eighth: DI,
                                               _ ninth: DI,
                                               _ tenth: DI,
                                               _ rest: DI...) -> MonoidDI<DI> where DI.Implementation : Monoid {
        MonoidDI(dis: [first,
                       second,
                       third,
                       fourth,
                       fifth,
                       sixth,
                       seventh,
                       eighth,
                       ninth,
                       tenth,] + rest)
    }
    
}


public struct MonoidDI<DI : DIParticipant> : DIParticipant where DI.Implementation : Monoid {
    
    let dis : [DI]
    
    public func inject(dependencies: Dependencies) -> DI.Implementation {
        dis.map{$0.inject(dependencies: dependencies)}.reduce(.empty, <>)
    }
    
}


infix operator <> : AdditionPrecedence


///A Monoid enables composing objects of the same type into new objects of this type.
public protocol Monoid {
    
    ///The empty object.
    static var empty : Self{get}
    
    ///Composes this value with another value.
    /// - Parameters:
    ///     - other: The other value.
    ///
    ///Only conform to Monoid if this composition is associative and composition with the empty object doesn't do anything.
    func compose(with other: Self) -> Self
    
    ///Composes two values.
    /// - Parameters:
    ///     - lhs: The first value.
    ///     - rhs: The second value.
    ///
    ///Only conform to Monoid if this composition is associative and composition with the empty object doesn't do anything.
    static func <>(lhs: Self, rhs: Self) -> Self
    
}


public extension Monoid {
    
    static func <>(lhs: Self, rhs: Self) -> Self {
        lhs.compose(with: rhs)
    }
    
}

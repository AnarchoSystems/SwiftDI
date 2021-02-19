//
//  Composition.swift
//  
//
//  Created by Markus Pfeifer on 19.02.21.
//

import Foundation


extension DIParticipant {
    
    
    ///Joins the constructed object using the given closure.
    /// - Parameters:
    ///     - other: The other DIParticipant.
    ///     - combine: A way to combine the two objects after injection.
    func compose<Other : DIParticipant, NewValue>(with other: Other, _ combine: @escaping (Implementation, Other.Implementation) -> NewValue) -> ComposedDI<Self, Other, NewValue> {
        ComposedDI(di1: self, di2: other, compose: combine)
    }
    
}

@_functionBuilder
public struct DIBuilder {}


///A chain of DIParticipants.
public struct Chain<Chain : DIParticipant> : DIParticipant {
    
    let base : Chain
    
    public init(@DIBuilder content: () -> Chain) {
        self.base = content()
    }
    
    public func inject(dependencies: Dependencies) -> Chain.Implementation {
        base.inject(dependencies: dependencies)
    }
    
}


public struct ComposedDI<DI1 : DIParticipant, DI2 : DIParticipant, NewValue> : DIParticipant {
    
    let di1 : DI1
    let di2 : DI2
    let compose : (DI1.Implementation, DI2.Implementation) -> NewValue
    
    public func inject(dependencies: Dependencies) -> NewValue {
        compose(di1.inject(dependencies: dependencies),
                di2.inject(dependencies: dependencies))
    }
    
}

//
//  FlatMap.swift
//  
//
//  Created by Markus Pfeifer on 19.02.21.
//

import Foundation



public extension DIParticipant {
    
    
    ///Applies a transformation to the constructed object.
    /// - Parameters:
    ///     - transform: The transformation to apply after dependency injection.
    func map<NewValue>(_ transform: @escaping (Implementation) -> NewValue) -> MapDI<Self, NewValue> {
        MapDI(base: self, map: transform)
    }
    
    ///Applies a transformation to the constructed object.
    /// - Parameters:
    ///     - transform: The transformation to apply after dependency injection.
    func flatMap<Next : DIParticipant>(_ transform: @escaping (Implementation) -> Next) -> FlatMapDI<Self, Next> {
        FlatMapDI(base: self, flatMap: transform)
    }
    
}


public struct MapDI<Base: DIParticipant, NewValue> : DIParticipant {
    
    let base : Base
    let map : (Base.Implementation) -> NewValue
    
    public func inject(dependencies: Dependencies) -> NewValue {
        map(base.inject(dependencies: dependencies))
    }
    
}


public struct FlatMapDI<Base : DIParticipant, Next : DIParticipant> : DIParticipant {
    
    let base : Base
    let flatMap : (Base.Implementation) -> Next
    
    public func inject(dependencies: Dependencies) -> Next.Implementation {
        flatMap(base.inject(dependencies: dependencies)).inject(dependencies: dependencies)
    }
    
}



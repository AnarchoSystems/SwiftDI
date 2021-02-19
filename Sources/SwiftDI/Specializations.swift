//
//  Specializations.swift
//  
//
//  Created by Markus Pfeifer on 19.02.21.
//

import Foundation



///Wraps a more complex DIParticipant into a whole.
public protocol DIWrapper : DIParticipant {
    
    associatedtype Body : DIParticipant
    var body : Body{get}
    
}


public extension DIWrapper {
    
    func inject(dependencies: Dependencies) -> Body.Implementation {
        body.inject(dependencies: dependencies)
    }
    
}


///Enables an object that doesn't depend on the Environment to participate in the DI hierarchy.
public protocol PureDIParticipant : DIParticipant {
    
    var body : Implementation{get}
    
}


public extension PureDIParticipant {
    
    func inject(dependencies: Dependencies) -> Implementation {
        body
    }
    
}

//
//  SwiftDI.swift
//  
//
//  Created by Markus Pfeifer on 12.02.21.
//

import Foundation


//MARK: CORE


///EnvironmentKey types are used mainly to provide safe subscript keys for Depencies.
public protocol EnvironmentKey {
    associatedtype Value
    static var defaultValue : Value{get}
}


///Dependencies are a wrapper type capable of storing all kinds of values in a safe manner.
public struct Dependencies {
    
    public init(){}
    
    ///The backing storage of all the values.
    private var storage : [String : Any] = [:]
    
    ///This is a type-safe interface to access stored values.
    public subscript<K : EnvironmentKey>(_ key: K.Type) -> K.Value {
        get {
            storage[String(describing: K.self)] as? K.Value ?? K.defaultValue
        }
        set {
            storage[String(describing: K.self)] = newValue
        }
    }
    
    ///Tells if the storage has a value for the given key.
    public func hasInjectedValue<Key : EnvironmentKey>(forKey key: Key.Type) -> Bool {
        storage[String(describing: Key.self)] != nil
    }
    
}


//MARK: INJECTION


///A DIParticipant enables passing around dependencies throughout your object hierarchy implicitly.
public protocol DIParticipant {
    
    ///The object type injected by this DI Participant.
    associatedtype Implementation
    
    ///Constructs the desired object.
    /// - Parameters:
    ///     - dependencies: The object's global dependencies.
    func inject(dependencies: Dependencies) -> Implementation
    
}


public extension DIParticipant {
    
    ///Constructs the desired object using the default environment.
    func inject() -> Implementation {
        inject(dependencies: Dependencies())
    }
    
}


//MARK: MODIFICATION


public extension DIParticipant {
    
    ///Modifies the environment for all nested objects.
    /// - Parameters:
    ///     - kp: A keypath to the environment value to modify.
    ///     - value: The new value to assign.
    func environment<Value>(_ kp: WritableKeyPath<Dependencies, Value>, value: Value) -> Modified<Self, Value> {
        Modified(base: self, value: value, kp: kp)
    }
    
    
    ///Modifies the environment for all nested objects.
    /// - Parameters:
    ///     - key: A key to the environment value to modify.
    ///     - value: The new value to assign.
    func environment<Key : EnvironmentKey>(_ key: Key.Type, value: Key.Value) -> KeyModified<Self, Key> {
        KeyModified(base: self, value: value)
    }
    
}


public struct Modified<Component : DIParticipant, Value> : DIParticipant {
    
    let base : Component
    let value : Value
    let kp : WritableKeyPath<Dependencies, Value>
    
    public func inject(dependencies: Dependencies) -> Component.Implementation {
        var dependencies = dependencies
        dependencies[keyPath: kp] = value
        return base.inject(dependencies: dependencies)
    }
    
}


public struct KeyModified<Component : DIParticipant, Key : EnvironmentKey> : DIParticipant {
    
    let base : Component
    let value : Key.Value
    
    public func inject(dependencies: Dependencies) -> Component.Implementation {
        var dependencies = dependencies
        dependencies[Key.self] = value
        return base.inject(dependencies: dependencies)
    }
    
}

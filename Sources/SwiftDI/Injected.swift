//
//  Injected.swift
//
//
//  Created by Markus Kasperczyk on 2.10.22.
//

public protocol Reader {
    func readValue(from environment: Any)
}

@propertyWrapper
public struct _Lens<Whole, Value> : Reader {
    
    @inlinable
    public var wrappedValue : Value {
        _wrappedValue.value!
    }
    @usableFromInline
    let _wrappedValue : Box
    private let _read : @MainActor (Whole) -> Value
    
    public init(_ read: @escaping @MainActor (Whole) -> Value) {
        self._read = read
        self._wrappedValue = Box()
    }
    
    public init() where Whole == Value {
        self = _Lens({$0})
    }
    
    @MainActor
    public func readValue(from environment: Any) {
        guard let environment = environment as? Whole else {return}
        _wrappedValue.value = _read(environment)
        inject(environment: environment, to: _wrappedValue.value!)
    }
 
    @usableFromInline
    internal final class Box {
        @usableFromInline
        var value : Value?
    }
    
}


public typealias Injected<Value> = _Lens<Dependencies, Value>

public func inject<Whole>(environment: Whole, to object: Any) {
    
    let mirror = Mirror(reflecting: object)
    
    var children = Array(mirror.children)
    
    while !children.isEmpty {
        let (_, child) = children.removeLast()
        if let reader = child as? Reader {
            reader.readValue(from: environment)
        }
        else {
            children.append(contentsOf: Mirror(reflecting: child).children)
        }
    }
    
}

import XCTest
@testable import SwiftDI

final class SwiftDITests: XCTestCase {
    
    
    func testExample() {
        let foo = Foo().environment(\.myKey, value: 1337).inject()
        XCTAssert(foo == 1337)
    }
    
    
    func testMonoid() {
        let chain = Chain {
            Foo()
            Foo()
            Foo()
        }
        
        XCTAssertEqual(chain.inject(),
                       3 * 42)
        
    }
    
    
    static var allTests = [
        ("testExample", testExample),
    ]
    
    
}



struct MyKey : EnvironmentKey {
    
    static var defaultValue : Int {
        42
    }
    
}

extension Dependencies {
    var myKey : Int {
        get {
            self[MyKey.self]
        }
        set {
            self[MyKey.self] = newValue
        }
    }
}

struct Foo : DIParticipant {
    
    func inject(dependencies: Dependencies) -> Int {
        dependencies.myKey
    }
    
}


extension Int : Monoid {
    
    public static var empty : Int {0}
    
    public func compose(with other: Int) -> Int {
        self + other
    }
    
}

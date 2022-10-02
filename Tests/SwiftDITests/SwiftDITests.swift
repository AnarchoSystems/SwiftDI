import XCTest
@testable import SwiftDI

final class SwiftDITests: XCTestCase {
    
    @MainActor
    func testNoRefCycles() {
        
        var hasDeinited = false
        
        do {
            
            let env = Dependencies {
                Bind(\.foo, to: Foo{hasDeinited = true})
            }
            
            inject(environment: env, to: env.foo)
            
            XCTAssert(env.foo === env.foo.bar.foo)
            
        }
        
        XCTAssert(hasDeinited)
        
    }
    
    
}


class Foo : Dependency {
    
    static let defaultValue = Foo{}
    
    @Injected(\.bar) var bar : Bar
    
    let onDeinit : () -> Void
    
    init(_ onDeinit: @escaping () -> Void) {
        self.onDeinit = onDeinit
    }
    
    deinit {
        onDeinit()
    }
    
}


class Bar : Dependency {
    
    static let defaultValue = Bar()
    
    @Injected(\.foo) var foo : Foo
    
}


extension Dependencies {
    
    @MainActor
    var foo : Foo {
        _read {yield self[Foo.self]}
        _modify {yield &self[Foo.self]}
    }
    
    @MainActor
    var bar : Bar {
        _read {yield self[Bar.self]}
        _modify {yield &self[Bar.self]}
    }
    
}

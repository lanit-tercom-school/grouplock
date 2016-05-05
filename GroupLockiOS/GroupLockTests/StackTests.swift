//
//  StackTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class StackTests: XCTestCase {
    
    var sut = Stack<Int>()
    let initialCount = 10
    
    override func setUp() {
        super.setUp()
        
        for i in 0..<initialCount {
            sut.items.append(i)
        }
    }
    
    override func tearDown() {
        
        sut.items.removeAll()
        
        super.tearDown()
    }
    
    func testPush() {
        sut.push(101)
        XCTAssertEqual(sut.items.count, initialCount + 1)
        XCTAssertEqual(sut.items[initialCount], 101)
    }
    
    func testPop() {
        let popped = sut.pop()
        XCTAssertEqual(sut.items.count, initialCount - 1)
        XCTAssertEqual(popped, initialCount - 1)
        
        sut.items.removeAll()
        XCTAssertNil(sut.pop())
    }
    
    func testPeek() {
        let head = sut.peek()
        XCTAssertEqual(sut.items.count, initialCount)
        XCTAssertEqual(head, initialCount - 1)
        
        sut.items.removeAll()
        XCTAssertNil(sut.peek())
    }
    
    func testIsEmpty() {
        XCTAssertEqual(sut.isEmpty, sut.items.isEmpty)
    }
}

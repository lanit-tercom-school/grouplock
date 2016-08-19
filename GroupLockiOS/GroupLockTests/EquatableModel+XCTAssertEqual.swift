//
//  EquatableModel+XCTAssertEqual.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 26.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest

internal protocol EquatableModel {
    func isEqualTo(_: Self) -> Bool
}


internal func XCTAssertEqual<T: EquatableModel>(_ expression1: @autoclosure () throws -> T?,
                                   _ expression2: @autoclosure () throws -> T?,
                                   _ message: @autoclosure () -> String = "",
                                   file: StaticString = #file,
                                   line: UInt = #line) {

    func assertion(_ expression1: @autoclosure () throws -> T?,
                   _ expression2: @autoclosure () throws -> T?) rethrows -> Bool {

        let (value1, value2) = (try expression1(), try expression2())

        if value1 == nil && value2 == nil {
            return true
        }

        if let value1 = value1, let value2 = value2 {
            return value1.isEqualTo(value2)
        }

        return false
    }


    XCTAssert(try assertion(expression1, expression2), message, file: file, line: line)
}

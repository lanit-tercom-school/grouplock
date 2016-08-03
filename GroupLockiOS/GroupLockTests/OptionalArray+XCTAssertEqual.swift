//
//  OptionalArray+XCTAssertEqual.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest

internal func XCTAssertEqual<T: Equatable>(@autoclosure expression1: () throws -> [T]?,
                                   @autoclosure _ expression2: () throws -> [T]?,
                                   @autoclosure _ message: () -> String = "",
                                   file: StaticString = #file,
                                   line: UInt = #line) {

    func nilAssertion(@autoclosure expression1: () throws -> [T]?,
                                @autoclosure _ expression2: () throws -> [T]?) rethrows -> Bool {

        let (value1, value2) = (try expression1(), try expression2())

        if value1 == nil && value2 == nil {
            return true
        }
        return false
    }

    do {
        let bothNil = try nilAssertion(expression1, expression2)
        if bothNil {
            XCTAssert(true, message, file: file, line: line)
        } else if let value1 = try expression1(), value2 = try expression2() {
            XCTAssertEqual(value1, value2, message, file: file, line: line)
        } else {
            XCTFail(message(), file: file, line: line)
        }
    } catch {
        XCTAssert(try nilAssertion(expression1, expression2), message, file: file, line: line)
    }

}

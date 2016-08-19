//
//  OptionalArray+XCTAssertEqual.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 27.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest

internal func XCTAssertEqual<T: Equatable>(_ expression1: @autoclosure () throws -> [T]?,
                                   _ expression2: @autoclosure () throws -> [T]?,
                                   _ message: @autoclosure () -> String = "",
                                   file: StaticString = #file,
                                   line: UInt = #line) {

    func nilAssertion(_ expression1: @autoclosure () throws -> [T]?,
                                _ expression2: @autoclosure () throws -> [T]?) rethrows -> Bool {

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
        } else if let value1 = try expression1(), let value2 = try expression2() {
            XCTAssertEqual(value1, value2, message, file: file, line: line)
        } else {
            XCTFail(message(), file: file, line: line)
        }
    } catch {
        XCTAssert(try nilAssertion(expression1, expression2), message, file: file, line: line)
    }

}

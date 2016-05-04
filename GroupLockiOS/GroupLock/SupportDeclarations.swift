//
//  SupportDeclarations.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 05.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Foundation

/**
 *  `Stack` is an abstract data type that serves as a collection of elements, with two principal operations: push, which adds an element to the collection, and pop, which removes the most recently added element that was not yet removed. The order in which elements come off a stack gives rise to its alternative name, LIFO (for last in, first out). Additionally, a peek operation may give access to the top without modifying the stack.
 */
struct Stack<Element> {
    private var items = [Element]()
    
    /**
     Returns true iff self is empty.
     - complexity: O(1)
    */
    var isEmpty: Bool {
        #if swift(>=2.2)
            return items.isEmpty
        #else
            return items.count == 0
        #endif
    }
    
    /**
     Append newElement to the Array.
     
     - complexity: O(1)
     */
    mutating func push(newElement: Element) {
        items.append(newElement)
    }
    
    /**
     If `!self.isEmpty`, remove the last element and return it, otherwise return nil.
     - complexity: O(1)
     */
    mutating func pop() -> Element? {
        if items.isEmpty {
            return nil
        }
        return items.removeLast()
    }
    
    /**
     Returns the last element
     */
    func peek() -> Element? {
        if items.isEmpty {
            return nil
        }
        return items[items.endIndex - 1]
    }
}

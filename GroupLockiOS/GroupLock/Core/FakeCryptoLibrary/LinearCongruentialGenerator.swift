//
//  LinearCongruentialGenerator.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 17.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

/// Pseudorandom number generator (implementation is taken from the book "The Swift Progremming Language")
///
/// See: [Linear congruential generator (Wikipedia)](https://en.wikipedia.org/wiki/Linear_congruential_generator)
class LinearCongruentialGenerator {

    var seed: Double

    // MARK: Good constants for the generator

    // swiftlint:disable variable_name
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    // swiftlint:enable variable_name

    /**
     Generate next pseudorandom number

     - returns: Pseudorandom floating point number from 0 to 1
     */
    func random() -> Double {
        seed = (seed * a + c).truncatingRemainder(dividingBy: m)
        return seed / m
    }

    /**
     Create a new generator with given initial value

     - parameter seed: Initial value

     */
    init(seed: Double) {
        self.seed = seed
    }
}

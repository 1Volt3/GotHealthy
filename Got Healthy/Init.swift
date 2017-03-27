//
//  Init.swift
//  Got Healthy
//
//  Created by Josh Rosenzweig on 3/17/17.
//  Copyright © 2017 Volt. All rights reserved.
//

import Foundation


func Init<T>( _ object: T, block: (T) throws -> ()) rethrows -> T{
    try block(object)
    return object
}

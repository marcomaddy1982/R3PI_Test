//
//  Product.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import Foundation

struct Product {
    var name: String?
    var price: NSNumber?
    var unit:String?
    var imageUrl:String?
}

extension Product: Equatable {}

func ==(lhs: Product, rhs: Product) -> Bool {
    let areEqual = lhs.name == rhs.name
    return areEqual
}

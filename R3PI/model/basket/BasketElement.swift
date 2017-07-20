//
//  BasketElement.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class BasketElement: NSObject {
    var product: Product?
    var amount: Int = 0
    var totalPrice: NSNumber {
        guard let price = product?.price, price.floatValue > 0, amount > 0  else {return NSNumber(value:0.0)}
        return NSNumber(value: price.floatValue * Float(amount))
    }
}

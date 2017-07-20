//
//  BasketProvider.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

private let _sharedInstance = BasketProvider()

class BasketProvider: NSObject {

    var basket: [BasketElement]
    let isolationQueue = DispatchQueue(label: "isolationQueue")
    
    // MARK: lifecycle
    override init() {
        basket = []
    }
    
    class var sharedInstance: BasketProvider {
        return _sharedInstance
    }
    
    var basketCount: Int {
        var count = 0
        isolationQueue.sync {
            count = self.basket.count
        }
        return count
    }
    
    var basketAmount: NSNumber {
        var totAmout: Float = 0.0
        for basketElement in self.basket  {
            totAmout += basketElement.totalPrice.floatValue
        }
        return NSNumber(value: totAmout)
    }
    
    // MARK: public implementation
    func addBesketElement(element:BasketElement, completitionHandler: BasketCompletitionHandler?) {
        isolationQueue.async {
            self.basket.append(element)
            if (completitionHandler != nil) {
                completitionHandler!()
            }
        }
    }
    
    func updateBesketElementAmount(element:BasketElement, completitionHandler: BasketCompletitionHandler?) {
        isolationQueue.async {
            element.amount += 1
            if (completitionHandler != nil) {
                completitionHandler!()
            }
        }
    }
    
    func removeBesketElement(at index: Int, completitionHandler: BasketCompletitionHandler?) {
        isolationQueue.async {
            self.basket.remove(at: index)
            if (completitionHandler != nil) {
                completitionHandler!()
            }
        }
    }
    
    func emptyBasket(completitionHandler: BasketCompletitionHandler?) {
        isolationQueue.async {
            self.basket = []
            if (completitionHandler != nil) {
                completitionHandler!()
            }
        }
    }
}

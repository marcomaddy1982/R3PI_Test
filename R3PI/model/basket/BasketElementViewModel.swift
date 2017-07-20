//
//  BasketElementViewModel.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

struct BasketElementViewModel {

    private(set) var basketElement: BasketElement?
    private var numberFormatter:NumberFormatter
    
    init(basketElement: BasketElement?) {
        self.basketElement = basketElement
        self.numberFormatter = NumberFormatter.init()
        self.numberFormatter.maximumFractionDigits = 2
        self.numberFormatter.minimumFractionDigits = 2
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.paddingCharacter = ""
        self.numberFormatter.paddingPosition = .afterPrefix
        self.numberFormatter.formatWidth = 7
        self.numberFormatter.currencyCode = "USD"
    }
    
    var nameText: String {
        guard let name = self.basketElement?.product?.name, name != "" else { return "No Name"}
        return name
    }
    
    var amountText: String {
        guard let amount = basketElement?.amount, amount > 0 else { return "No Amount"}
        return String(format: "Amount: %d", amount)
    }
    
    var priceText: String {
        guard let price = self.basketElement?.product?.price, price.floatValue > 0, let amount = basketElement?.amount, amount != 0 else { return "No Price"}
        
        let totalPrice = NSNumber(value: price.floatValue * Float(amount))
        
        guard let totalPriceFormatted = self.numberFormatter.string(from: totalPrice) else {
            return "No Price"
        }
        
        return String(format: "Price: %@", totalPriceFormatted)
    }
}

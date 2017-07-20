//
//  CheckoutViewModel.swift
//  R3PI
//
//  Created by Marco Maddalena on 18/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

struct CheckoutViewModel{

    private(set) var checkout: Checkout?
    private var dateFormatter:DateFormatter
    private var numberFormatter:NumberFormatter
    
    init(checkout: Checkout?) {
        self.checkout = checkout
        self.dateFormatter = DateFormatter.init()
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.numberFormatter = NumberFormatter.init()
        self.numberFormatter.maximumFractionDigits = 2
        self.numberFormatter.minimumFractionDigits = 2
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.paddingCharacter = ""
        self.numberFormatter.paddingPosition = .afterPrefix
        self.numberFormatter.formatWidth = 8
    }
    
    var checkoutText: String? {
        guard let currencyCode = self.checkout?.currencyCode, currencyCode != "" else { return "No currency." }
        self.numberFormatter.currencyCode = self.checkout?.currencyCode
        
        guard let quote = checkout?.quote, quote.floatValue > 0.0, let totAmount = checkout?.totalAmout, totAmount.floatValue > 0 else { return "No checkout." }
        let checkoutAmount = NSNumber(value: quote.floatValue * totAmount.floatValue)
        guard let formattedCheckoutAmount = self.numberFormatter.string(from: checkoutAmount) else {
            return "No checkout."
        }

        guard let timestamp = checkout?.timestamp, timestamp > 0 else { return "Total Amount: " + formattedCheckoutAmount }
        
        let date = NSDate(timeIntervalSince1970: timestamp)
        let dateStr = dateFormatter.string(from: date as Date)
        
        let checkoutText = "Date: " + dateStr + "\nTotal Amount: " + formattedCheckoutAmount
        
        return checkoutText
    }
}

//
//  ProductViewModel.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

struct ProductViewModel {

    private(set) var product: Product?
    private var numberFormatter:NumberFormatter
    
    init(product: Product?) {
        self.product = product
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
        guard let name = product?.name, name != ""  else { return "No Name"}
        return name
    }
    
    var priceText: String {
        guard let price = product?.price, price.floatValue > 0.0 ,let formattedPrice = numberFormatter.string(from: price) else { return "No Price"}
        guard let unit = product?.unit, unit != "" else { return "Price: " + formattedPrice}
        return "Price: " + formattedPrice + " per " + unit
    }
    
    var imgURL: URL? {
        guard let url = product?.imageUrl, url != ""  else { return nil }
        return URL(string: url)
    }
}

//
//  ProductsViewModel.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class ProductsViewModel {
    
    let products: [Product] = [Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg"),
                               Product(name: "Eggs", price: NSNumber(value: 2.10), unit: "dozen", imageUrl: "http://www.thepeoplesmarketperth.com.au/order/image/cache/data/eggs/eggs%2012%20pack-600x600.jpg"),
                               Product(name: "Milk", price: NSNumber(value: 1.30), unit: "bottle", imageUrl: "https://previews.123rf.com/images/boettcher/boettcher1101/boettcher110100067/8573979-Fresh-Milk-Bottle-Isolated-on-White-Background-Stock-Photo-box.jpg"),
                               Product(name: "Beans", price: NSNumber(value: 0.73), unit: "can", imageUrl: "http://assets.bonappetit.com/photos/57daf5809f19b4610e6b7058/5:4/w_2056,c_limit/bas-best-640.jpg")]
    
    var productsCount: Int {
        return self.products.count
    }
    
    func productViewModel(at index: Int) -> ProductViewModel {
        return ProductViewModel(product: self.products[index])
    }
    
    func addProduct(product:Product, completitionHandler: BasketCompletitionHandler?) {
        DispatchQueue.global().async {
            let basket = BasketProvider.sharedInstance.basket
            for basketElement in basket {
                if basketElement.product == product {
                    BasketProvider.sharedInstance.updateBesketElementAmount(element: basketElement, completitionHandler: completitionHandler)
                    return
                }
            }
            
            let basketElement = BasketElement()
            basketElement.product = product
            basketElement.amount = 1
            BasketProvider.sharedInstance.addBesketElement(element: basketElement, completitionHandler: completitionHandler)
        }
    }
}

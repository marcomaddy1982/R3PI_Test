//
//  BasketViewModel.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit
typealias BasketCompletitionHandler = () -> Void
typealias ConvertSuccessBlock = (AnyObject)-> Void
typealias ConvertFailureBlock = (R3Error) -> Void

class BasketViewModel: NSObject {
    
    var basketElementsCount: Int {
        return BasketProvider.sharedInstance.basket.count
    }
    
    var checkout: Checkout? = nil
    
    func basketElementViewModel(at index: Int) -> BasketElementViewModel {
        return BasketElementViewModel(basketElement: BasketProvider.sharedInstance.basket[index])
    }
    
    func removeBasketElement(at index: Int, completitionHandler: BasketCompletitionHandler?) {
        BasketProvider.sharedInstance.removeBesketElement(at: index, completitionHandler: completitionHandler)
    }
    
    func emptyBasket(completitionHandler: BasketCompletitionHandler?) {
        BasketProvider.sharedInstance.emptyBasket(completitionHandler: completitionHandler)
    }

    func getLiveConvert(to: String, success:@escaping ConvertSuccessBlock, failure:@escaping ConvertFailureBlock) {
        DispatchQueue.global().async {
            let provider = ApiProvider(service: NetworkService.getLiveConvert(to: to))
            provider.start(completionHandler: { (data, response, error) in
                if data != nil {
                    let result = DataParser.parserGetLiveConvert(dataToParse: data! as NSData)
                    if let checkout = result.0{
                            self.checkout = checkout
                            self.checkout?.totalAmout = BasketProvider.sharedInstance.basketAmount
                            self.checkout?.currencyCode = CurrencyProvider.sharedInstance.selectedCurrencyCode
                            success(CheckoutViewModel(checkout: self.checkout) as AnyObject)
                    } else if let error = result.1, !error.isValid() {
                        failure(error)
                    } else {
                        var error = R3Error()
                        error.code = 101
                        error.info = AlertMessages.kAlert_ServiceNotAbailable_Message
                        failure(error)
                    }
                } else {
                    var error = R3Error()
                    error.code = 101
                    error.info = AlertMessages.kAlert_ServiceNotAbailable_Message
                    failure(error)
                }
            })
        }
    }
}

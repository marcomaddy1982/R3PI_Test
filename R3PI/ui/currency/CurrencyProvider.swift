//
//  CurrencyViewModel.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

typealias ConcurrencySuccessBlock = ()-> Void
typealias ConcurrencyFailureBlock = (R3Error) -> Void

private let _sharedInstance = CurrencyProvider()

class CurrencyProvider: NSObject {
    
    var currencies: [Currency]
    var selectedCurrencyCode = "USD"
    
    var currenciesCount: Int {
        return self.currencies.count
    }
    
    // MARK: lifecycle
    override init() {
        currencies = []
    }
    
    class var sharedInstance: CurrencyProvider {
        return _sharedInstance
    }
    
    // MARK: Public implementation
    
    func getConcurrencyWithSuccess(success:@escaping ConcurrencySuccessBlock, failure:@escaping ConcurrencyFailureBlock) {
        DispatchQueue.global().async {
            let provider = ApiProvider(service: NetworkService.getCurrencyList)
            provider.start(completionHandler: { (data, response, error) in
                if data != nil {
                    let result = DataParser.parserGetCurrency(dataToParse: data! as NSData)
                    
                    if let currencies = result.0, currencies.count > 0 {
                        self.currencies = currencies
                        success()
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
    
    func currency(at index: Int) -> Currency {
        return self.currencies[index]
    }
    
    func isSelectedCurrency(currency: Currency) -> Bool {
        return currency.key == self.selectedCurrencyCode
    }
    
    func setSelectCurrencyCode(at index: Int) {
        self.selectedCurrencyCode = self.currency(at: index).key
    }
}

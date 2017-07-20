//
//  CurrencyViewController.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

protocol CurrencyViewControllerDelegate:class {
    func currencyViewControllerDidClose()
}

class CurrencyViewController: UITableViewController {

    // MARK: IBOutlet
    @IBOutlet weak var tableCurrency: UITableView!
    
    // MARK: property
    weak var delegate : CurrencyViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private implementation
    
    func setUpLayout() {
        self.title = "Currencies"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(close))
        
        if CurrencyProvider.sharedInstance.currenciesCount == 0 {
            self.startGetCurrencies()
        }else{
            self.reloadCurrencyTable()
        }
    }
    
    func close() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                if CurrencyProvider.sharedInstance.currencies.count > 0 {
                    self.delegate?.currencyViewControllerDidClose()
                }
            })
        }
    }
    
    func startGetCurrencies() {
        let reachableBlock: ConnectivitySuccessBlock = {
            LoadingViewController.sharedInstance.showWithParentViewController(parentViewController: self)
            CurrencyProvider.sharedInstance.getConcurrencyWithSuccess(success: {
                
                LoadingViewController.sharedInstance.hide()
                self.reloadCurrencyTable()
                
            }) { (error) in
                LoadingViewController.sharedInstance.hide()
                self.showServiceErrorAlert(error: error)
            }
        }
        
        let unReachableBlock: ConnectivityFailureBlock = {
            LoadingViewController.sharedInstance.hide()
            self.showUnReachableAlert()
        }
        
        ConnectivityManager.sharedInstance.executeBlockIfConnectionIsAvailable(success: reachableBlock, failure: unReachableBlock)
    }
    
    func reloadCurrencyTable() {
        DispatchQueue.main.async {
            self.tableCurrency.reloadData()
        }
    }
    
    func showUnReachableAlert() {
        DispatchQueue.main.async {
            
            () -> Void in
            
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Title, message: AlertMessages.kAlert_ConnectionLost_Message, preferredStyle: UIAlertControllerStyle.alert)
            let retryButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_Retry, style: UIAlertActionStyle.default, handler: { (action) in
                self.startGetCurrencies()
            })
            
            alert.addAction(retryButton)
            let cancelButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_Cancel, style: UIAlertActionStyle.default, handler: { (action) in
                self.close()
            })
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showServiceErrorAlert(error: R3Error) {
        DispatchQueue.main.async {
            
            () -> Void in
            
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Title, message: error.info, preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_OK, style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrencyProvider.sharedInstance.currenciesCount
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCellView", for: indexPath)
        let currency = CurrencyProvider.sharedInstance.currency(at: indexPath.row)
        cell.textLabel?.text = currency.descr
        cell.accessoryType = CurrencyProvider.sharedInstance.isSelectedCurrency(currency: currency) ?UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CurrencyProvider.sharedInstance.setSelectCurrencyCode(at: indexPath.row)
        self.reloadCurrencyTable()
    }

}

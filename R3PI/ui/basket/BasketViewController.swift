//
//  BasketViewController.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class BasketViewController: UITableViewController {

    // MARK: IBOutlet
    @IBOutlet weak var tableBasket: UITableView!
    
    // MARK: public implementation
    var viewModel: BasketViewModel = BasketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkOut(sender:UIButton) {
        self.performSegue(withIdentifier: "CurrencySegue", sender: nil)
    }
    
    // MARK: private implementation
    func setUpLayout() {
        self.title = "Basket";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Empty", style: .plain, target: self, action: #selector(empty))
        tableBasket.allowsMultipleSelectionDuringEditing = false
    }
    
    func reloadBasketTable() {
        DispatchQueue.main.async {
            self.tableBasket.reloadData()
        }
    }
    
    func close() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func empty() {
        self.viewModel.emptyBasket { 
            self.reloadBasketTable()
            self.close()
        }
    }
    
    func startGetLiveConvert() {
        self.viewModel.getLiveConvert(to: CurrencyProvider.sharedInstance.selectedCurrencyCode, success: { object in
            LoadingViewController.sharedInstance.hide()
            self.showCheckoutAlert(object: object)
        }) { (error) in
            LoadingViewController.sharedInstance.hide()
            self.showServiceErrorAlert(error: error)
        }
    }
    
    func showCheckoutAlert(object: AnyObject) {
        let message = (object as! CheckoutViewModel).checkoutText
        
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Checkout_Title, message:message , preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_OK, style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showUnReachableAlert() {
        DispatchQueue.main.async {
            
            () -> Void in
            
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Title, message: AlertMessages.kAlert_ConnectionLost_Message, preferredStyle: UIAlertControllerStyle.alert)
            let retryButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_Retry, style: UIAlertActionStyle.default, handler: { (action) in
                self.startGetLiveConvert()
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
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.basketElementsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BasketViewCell = tableView.dequeueReusableCell(withIdentifier: "BasketViewCell", for: indexPath) as! BasketViewCell
        let basketElementViewModel: BasketElementViewModel = self.viewModel.basketElementViewModel(at: indexPath.row)
        cell.viewModel = basketElementViewModel
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constant.kBasketElementRowHeight)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.removeBasketElement(at: indexPath.row, completitionHandler: {
                self.reloadBasketTable()
                if self.viewModel.basketElementsCount == 0 {
                    self.close()
                }
            })
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "CurrencySegue" ,
            let navController = segue.destination as? UINavigationController {
            let currencyViewController = navController.viewControllers[0] as? CurrencyViewController
            currencyViewController?.delegate = self
        }
    }
}

extension BasketViewController: CurrencyViewControllerDelegate {
    func currencyViewControllerDidClose() {
        
        let reachableBlock: ConnectivitySuccessBlock = {
            LoadingViewController.sharedInstance.showWithParentViewController(parentViewController: self)
            self.startGetLiveConvert()
        }
        
        let unReachableBlock: ConnectivityFailureBlock = {
            LoadingViewController.sharedInstance.hide()
            self.showUnReachableAlert()
        }
        
        ConnectivityManager.sharedInstance.executeBlockIfConnectionIsAvailable(success: reachableBlock, failure: unReachableBlock)
    }
}

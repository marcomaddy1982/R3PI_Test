//
//  ProductsViewController.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    // MARK: IBOutlet
    @IBOutlet weak var collectionProducts: UICollectionView!
    
    // MARK: public implementation
    var viewModel: ProductsViewModel = ProductsViewModel()
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: private implementation
    func setUpLayout() {
        self.title = "Products";
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Basket", style: .plain, target: self, action: #selector(openBasket))
    }
    
    func openBasket(sender: UIBarButtonItem) {
        if BasketProvider.sharedInstance.basketCount > 0 {
            self.performSegue(withIdentifier: "BasketSegue", sender: nil)
        }else{
            self.showNoElementAlert()
        }
    }
    
    // MARK: private implementtion
    
    func showAddedElementAlert() {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Title, message: AlertMessages.kAlert_AddedElement_Message, preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_OK, style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showNoElementAlert() {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: AlertMessages.kAlert_Attention_Title, message: AlertMessages.kAlert_NoElement_Message, preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: AlertMessages.kAlert_Common_Button_OK, style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: CollectionViewDelegate - CollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.productsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductViewCell", for: indexPath) as! ProductViewCell
        cell.delegate = self
        let productViewModel = self.viewModel.productViewModel(at: indexPath.row)
        cell.viewModel = productViewModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (UIScreen.main.bounds.size.height - CGFloat(Constant.kNavigationBarHeight))/2.0
        let width: CGFloat = UIScreen.main.bounds.size.width/2.0
        
        return CGSize(width:width , height:height)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ProductsViewController: ProductViewCellDelegate {
    
    func productViewCellDidAddProduct(product:Product) {
        self.viewModel.addProduct(product: product) { 
            self.showAddedElementAlert()
        }
    }
}

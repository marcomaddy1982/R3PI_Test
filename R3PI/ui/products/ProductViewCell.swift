//
//  ProductViewself.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

protocol ProductViewCellDelegate:class {
    func productViewCellDidAddProduct(product:Product)
}

class ProductViewCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imwProduct: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: property
    weak var delegate : ProductViewCellDelegate?
    
    var viewModel: ProductViewModel? = nil {
        didSet {
            self.setUpLayout()
        }
    }
    
    // MARK: public implementation
    @IBAction func addProduct(sender:UIButton) {
        if (self.viewModel?.product) != nil {
            self.delegate?.productViewCellDidAddProduct(product: (self.viewModel?.product)!)
        }
    }
    
    // MARK: private implementation
    private func setUpLayout() {
        self.labelName.text = self.viewModel?.nameText
        self.labelPrice.text = self.viewModel?.priceText
        
        DispatchQueue.global().async {
            if let imgUrl = self.viewModel?.imgURL {
                do {
                    let data = try Data(contentsOf: imgUrl)
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.imwProduct.image = UIImage(data: data)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }    
}

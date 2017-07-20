//
//  BasketViewCell.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class BasketViewCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    // MARK: property
    var viewModel: BasketElementViewModel? = nil {
        didSet {
            self.setUpLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: private implementation
    private func setUpLayout() {
        self.labelName.text = self.viewModel?.nameText
        self.labelTotalPrice.text = self.viewModel?.priceText
        self.labelAmount.text = self.viewModel?.amountText
    }

}

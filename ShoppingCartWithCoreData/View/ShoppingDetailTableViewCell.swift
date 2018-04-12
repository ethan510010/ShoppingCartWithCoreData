//
//  ShoppingDetailTableViewCell.swift
//  ShoppingCartWithCoreData
//
//  Created by EthanLin on 2018/4/12.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class ShoppingDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemAmountLabel: UILabel!
    @IBOutlet weak var itemMoneyLabel: UILabel!
    
    
    func updateUI(data:MerChandise){
        itemNameLabel.text = "商品: \(data.name)"
        itemAmountLabel.text = "數量: \(data.number)"
        itemMoneyLabel.text = "NT: \((data.price)*(data.number))"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

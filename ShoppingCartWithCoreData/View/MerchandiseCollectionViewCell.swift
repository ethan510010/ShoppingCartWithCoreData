//
//  MerchandiseCollectionViewCell.swift
//  ShoppingCartWithCoreData
//
//  Created by EthanLin on 2018/4/11.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

protocol stepperDidTappedDelegate {
    func stepperDidTapped(index:IndexPath, merchandiseNumber:Int)
}

class MerchandiseCollectionViewCell: UICollectionViewCell {
    
    var index:IndexPath?
    var delegate:stepperDidTappedDelegate?
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    func updateUI(model:MerChandise){
        self.itemImage.image = UIImage(named: model.imageName)
        self.itemName.text = "商品名: \(model.name)"
        self.itemPrice.text = "價格: NT$\(model.price)元"
        self.itemNumber.text = "數量: \(model.number)"
        //要把原本值傳回去原本的stepper，這行很重要
        self.stepper.value = Double(model.number)
    }
    
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        guard let index = index else {return}
        delegate?.stepperDidTapped(index: index, merchandiseNumber: Int(sender.value))
    }
    
    
}

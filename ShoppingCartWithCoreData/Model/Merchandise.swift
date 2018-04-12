//
//  Merchandise.swift
//  ShoppingCartWithCoreData
//
//  Created by EthanLin on 2018/4/11.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

class MerChandise {
    var name:String
    var price:Int
    var number:Int
    var imageName:String
    
    init(name:String,price:Int,number:Int,imageName:String) {
        self.name = name
        self.price = price
        self.number = number
        self.imageName = imageName
    }
}

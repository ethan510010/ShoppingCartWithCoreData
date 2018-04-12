//
//  ViewController.swift
//  ShoppingCartWithCoreData
//
//  Created by EthanLin on 2018/4/11.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableTennisBlades = [MerChandise(name: "InnerforceZLC", price: 4500, number: 0, imageName: "innerforceZLC"),MerChandise(name: "InnerforceZLF", price: 3800, number: 0, imageName: "innerforceZLF"),MerChandise(name: "InnerforceAL", price: 2500, number: 0, imageName: "innerforceAL"),MerChandise(name: "Violin", price: 4200, number: 0, imageName: "violin"),MerChandise(name: "Accoustic", price: 4200, number: 0, imageName: "accoustic"),MerChandise(name: "Korbel", price: 2000, number: 0, imageName: "korbel"),MerChandise(name: "OC", price: 1200, number: 0, imageName: "OC")]
    
    @IBOutlet weak var merchandiseCollectionview: UICollectionView!
    
    @IBOutlet weak var merchandiseCollectionViewLayout: UICollectionViewFlowLayout!
    
    
    @IBOutlet weak var totalCost: UILabel!
    
    
    @IBAction func addToShoppingCart(_ sender: UIButton) {
    }
    
    @IBAction func goShoppingCart(_ sender: UIButton) {
        performSegue(withIdentifier: "goShoppingCart", sender: nil)
    }
    
    
    //因為還沒有建立CoreData先用傳值的方式來做效果
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goShoppingCart" else {return}
        guard let shoppingCartVC = segue.destination as? ShoppingCartViewController else { return }
        shoppingCartVC.delegate = self
        //把現在有的東西傳過去
        for eachMerchandise in tableTennisBlades{
            if eachMerchandise.number != 0 {
                shoppingCartVC.shoppingCart.append(eachMerchandise)
            }
        }
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        merchandiseCollectionview.delegate = self
        merchandiseCollectionview.dataSource = self

        merchandiseCollectionview.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        merchandiseCollectionViewLayout.itemSize.height = self.view.frame.height * (260/667)
        merchandiseCollectionViewLayout.itemSize.width = self.view.frame.width * (160/375)
        merchandiseCollectionViewLayout.minimumLineSpacing = 20
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, stepperDidTappedDelegate, WhichMerchandiseDeletedDelegate{
    
    //Merchandise刪除的Delegate
    func whichMerchandiseBeDeleted(merchandise: MerChandise) {
        
        var totalMoney = 0
        for eachItem in tableTennisBlades{
            if eachItem === merchandise{
                eachItem.number = 0
            }
            totalMoney += (eachItem.number * eachItem.price)
            self.totalCost.text = "總金額: \(totalMoney)"
        }
        
        self.merchandiseCollectionview.reloadData()
    }
    
    
    //Stepper的delegate
    func stepperDidTapped(index: IndexPath, merchandiseNumber: Int) {
        print(merchandiseNumber)
        self.tableTennisBlades[index.item].number = merchandiseNumber
        print(tableTennisBlades[index.item].number)
        
        self.merchandiseCollectionview.reloadData()

        //處理總金額
        var totalPrice = 0
        for itemSelected in tableTennisBlades{
            totalPrice += itemSelected.number * itemSelected.price
            self.totalCost.text = "總金額: \(totalPrice)"
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableTennisBlades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! MerchandiseCollectionViewCell
        itemCell.delegate = self
        itemCell.index = indexPath
        itemCell.updateUI(model: tableTennisBlades[indexPath.row])
        return itemCell
    }
    
    
}

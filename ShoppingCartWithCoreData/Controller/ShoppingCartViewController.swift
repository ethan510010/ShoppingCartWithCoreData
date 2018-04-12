//
//  ShoppingCartViewController.swift
//  ShoppingCartWithCoreData
//
//  Created by EthanLin on 2018/4/12.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import UIKit

protocol WhichMerchandiseDeletedDelegate {
    func whichMerchandiseBeDeleted(merchandise:MerChandise)
}

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak var shoppingDetailTableView: UITableView!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    
    var delegate:WhichMerchandiseDeletedDelegate?
    
    //總金額
    var totalMoney:Int = 0
    var shoppingCart = [MerChandise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingDetailTableView.delegate = self
        shoppingDetailTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for merchandise in shoppingCart{
            totalMoney += (merchandise.price * merchandise.number)
        }
        totalMoneyLabel.text = "總金額: NT$\(totalMoney)元"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingDetailCell", for: indexPath) as! ShoppingDetailTableViewCell
        if shoppingCart[indexPath.row].number != 0{
            cell.updateUI(data: shoppingCart[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //被刪除掉的那個merchandise的數量要歸零 並傳值到前面對應的merchandise
            delegate?.whichMerchandiseBeDeleted(merchandise: shoppingCart[indexPath.row])
            shoppingCart.remove(at: indexPath.row)

            
            self.totalMoney = 0
            for remainingMerchandise in shoppingCart{
                self.totalMoney += (remainingMerchandise.price * remainingMerchandise.number)
            }
            self.totalMoneyLabel.text = "總金額: NT$\(totalMoney)元"
            self.shoppingDetailTableView.reloadData()
        }
    }
    
    
}

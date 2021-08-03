//
//  ViewController.swift
//  SamsungUI
//
//  Created by Hemant Sharma on 03/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    var productInfoArray = [Product]()
    private var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let productInfoViewModel = ProductInfoViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
        self.view.addSubview(myTableView)
        myTableView.fillSuperview()
        productInfoViewModel.fetchProductDetails { [self] res in
            DispatchQueue.main.async {
                self.myTableView.reloadData()
                
            }
            
        }
        
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productInfoViewModel.productInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self)) as! CustomTableViewCell
        let productName = productInfoViewModel.productInfoArray[indexPath.row].name
        let productPrice = productInfoViewModel.productInfoArray[indexPath.row].price?.priceDisplay
        let productOfferPrice = productInfoViewModel.productInfoArray[indexPath.row].price?.offerPriceDisplay ?? ""
      let productImage = productInfoViewModel.productInfoArray[indexPath.row].images?[0]
        cell.configure(name: productName ?? "", priceDisplay: productPrice ?? "", offerPriceDisplay: productOfferPrice, imageURL: productImage ?? "")
        return cell
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}

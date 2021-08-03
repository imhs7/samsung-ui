//
//  Parser.swift
//  SamsungUI
//
//  Created by Hemant Sharma on 03/08/21.
//

import Foundation

class ProductInfoViewModel {
    
    var productInfoArray = [Product]()
    
    func getProductId() {
        
    }
    
    func fetchProductDetails(completion: @escaping (ResponseObject?) -> Void) {
        let url = URL(string: "https://www.blibli.com/backend/search/products?searchTerm=Samsung")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            do {
                let result = try JSONDecoder().decode(ResponseObject.self, from: data!)
                print(result)
                if let productArray = result.data?.products {
                    self.productInfoArray = productArray
                }
                completion(nil)
            }
            catch {
                completion(nil)
            }
            
        }.resume()
    }
}

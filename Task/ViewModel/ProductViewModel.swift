//
//  ProductViewModel.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import Foundation
protocol ProductViewModelProtocol {
    func productsResult()
}
public class ProductViewModel: ProductViewModelProtocol {
  
  
 
    var products: Products?{
        didSet{
            DispatchQueue.main.async {
                CoreDataManager.shared.saveProducts(products: self.products ?? [])
                self.view.ProductsSuccess(products: self.products ?? [])
            }
        }
           
    }
    weak private var view: ProductView!
    
    init(view: ProductView) {
        self.view = view
    }
    
   
}
//Function Extenison
extension ProductViewModel{
    
    
    func productsResult() {
        Network.shared.getResults(APICase: .getDefault,decodingModel: Products.self) { [weak self] (response) in
                switch response{
                    
                case .success(let data):
                    if self?.products == nil{
                        self?.products = data
                    }else {
                        self?.products?.append(contentsOf: data)
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
}

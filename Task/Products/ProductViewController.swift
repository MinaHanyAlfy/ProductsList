//
//  ProductViewController.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import UIKit


protocol ProductView: AnyObject {
    func ProductsSuccess(products: Products)
}

public class ProductViewController: UIViewController,ProductView {
   

    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: ProductViewModelProtocol!
    private var data: Products?
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
        viewModel = ProductViewModel(view: self)
        //CheckInternetCollection To fetchData and Save coreData
        viewModel.productsResult()
    }

   
}
extension ProductViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    
}

//Extension Functions
extension ProductViewController{
    private func navigationTitle(){
        if let navigationBar = self.navigationController?.navigationBar {

                   let frame = CGRect(x: navigationBar.center.x-(navigationBar.center.x/3), y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
                   let myMutableString = NSMutableAttributedString(string: "Products List", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
                   myMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
                                                          NSAttributedString.Key.foregroundColor: UIColor.black],
                                                         range: NSMakeRange(0, 13))
                   let lbl = UILabel(frame: frame)
                   lbl.attributedText = myMutableString
                   navigationBar.addSubview(lbl)
         }
    }
    private func registerCell(){
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
    func ProductsSuccess(products: Products) {
        self.data = products
    }
    
  
}

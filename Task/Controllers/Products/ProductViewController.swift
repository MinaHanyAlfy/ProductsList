//
//  ProductViewController.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import UIKit
import Network

protocol ProductView: AnyObject {
    func ProductsSuccess(products: Products)
}

public class ProductViewController: UIViewController,ProductView {
    let networkHandler = NetworkHandler.shared

    
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: ProductViewModelProtocol!
    private var data: Products?{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.layoutSubviews()
            }
        }
    }
    let coreDataManager = CoreDataManager.shared
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Products List"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
        viewModel = ProductViewModel(view: self)
        if let layout = collectionView?.collectionViewLayout as? ProductLayout {
            layout.delegate = self
            
        }
        checkConnection()
        
    }
}

extension ProductViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        guard let product = data?[indexPath.row] else{ return UICollectionViewCell()}
        cell.handleCell(product: product )
        cell.widthCells = (collectionView.width-36) / 2.0
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    //For sending product details.
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "productDesciption", sender: indexPath.row)
    }
    
    //Handling get more products.
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let products = data else{return}
        if indexPath.row == products.count - 1{
            moreProducts()
        }
    }
    
    
}

//Extension Functions
extension ProductViewController{
    
    private func registerCell(){
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let product = data?[sender as? Int ?? 0]  else{return}
        if segue.identifier == "productDesciption"{
            let descVc = segue.destination as! ProductDetailsViewController
            descVc.product = product
            
        }
    }
    
    func ProductsSuccess(products: Products) {
        
        DispatchQueue.main.async {
            self.data = products
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.layoutSubviews()
            self.collectionView.layoutIfNeeded()
        }
        
        
    }
    private func checkConnection(){
        
        if networkHandler.isConnected {
            self.viewModel.productsResult()
            self.collectionView.isHidden = false
        }else{
            if self.coreDataManager.countProducts() > 0{
                self.data = self.coreDataManager.getProducts()
                self.collectionView.isHidden = false
            }else{
                self.noProductsViewLayout()
            }
        }
        
     
        
    }
    
    private func noProductsViewLayout(){
        DispatchQueue.main.async {[self] in
            print("No Layout")
            collectionView.isHidden = true
            let noProudctView = ZeroStateView(frame: CGRect(x: 0, y: 0, width: view.width/2, height: view.width/2))
            noProudctView.center = view.center
            view.addSubview(noProudctView)
        }
        
    }
    
    func moreProducts(){
        viewModel.productsResult()
    }
    
}
extension ProductViewController: ProductLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForContentAtIndexPath indexPath:IndexPath) -> CGFloat {
            let heightImage = data?[indexPath.row].image?.height ?? 0
            guard let string = data?[indexPath.row].productDescription else {return 0}
            
            let heightLabel = UILabel.textHeight(withWidth: 150, font: UIFont.systemFont(ofSize: 17), text:  string)
            let heightPrice = 24
            let heightSpaces = 22
            let heightMarginSpace = 8
            let totalHeight = CGFloat(heightImage+Int(heightLabel)+heightSpaces+heightMarginSpace+heightPrice)
            
            return totalHeight
        }
    
}

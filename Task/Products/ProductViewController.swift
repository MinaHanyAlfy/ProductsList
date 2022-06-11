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
        navigationItem.title = "Products List"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
        viewModel = ProductViewModel(view: self)
        if let layout = collectionView?.collectionViewLayout as? ProductLayout {
          layout.delegate = self
            
        }
        viewModel.productsResult()
//        CoreDataMana
        print(CoreDataManager.shared.getProducts())
        
       
    }
}
extension ProductViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.handleCell(product: (data?[indexPath.row])!)
        cell.widthCells = (collectionView.width-36) / 2.0
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "productDesciption", sender: indexPath.row)
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
        self.data = products
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
        }
        

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

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
        if let layout = collectionView?.collectionViewLayout as? ProductLayout {
          layout.delegate = self
            
        }
        viewModel.productsResult()
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
          var heightLabel = 0.0
          let heightImage = data?[indexPath.row].image?.height ?? 0
          guard let string = data?[indexPath.row].productDescription else {return 0}
          heightLabel = UILabel.textHeight(withWidth: 150, font: UIFont.systemFont(ofSize: 17), text:  string)
        
          let heightPrice = 24
          let heightSpaces = 22
          let heightMarginSpace = 8
          let totalHeight = CGFloat(heightImage+Int(heightLabel)+heightSpaces+heightMarginSpace+heightPrice)
          
          return totalHeight
  }
    
}

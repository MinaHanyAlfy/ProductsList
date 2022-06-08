//
//  ProductViewController.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Products List"
        navigationTitle()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
        
    }

   
}
extension ProductViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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

}

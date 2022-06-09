//
//  ProductCollectionViewCell.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageHeight: NSLayoutConstraint!
    @IBOutlet weak var curLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    public var widthCells: CGFloat?
    private var imageSize: CGSize?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        super.layoutSubviews()
        productImageView.layoutIfNeeded()
        
    }
    public func handleCell(product: Product){
        curLabel.text = "\(product.price ?? 0)$"
        descLabel.text = product.productDescription
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        let height: CGFloat = CGFloat(product.image?.height ?? 0)
        productImageHeight.constant = height
        downloadImage(from: URL(string: product.image?.url ?? "https://www.dmplayhouse.com/wp-content/uploads/2019/12/13-512.png")!)
        
        
    }
   
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.productImageView.image = UIImage(data: data)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descLabel.text = ""
        curLabel.text = ""
        productImageView.image = nil
    }
}


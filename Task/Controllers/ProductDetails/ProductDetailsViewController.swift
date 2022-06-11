//
//  ProductDetailsViewController.swift
//  Task
//
//  Created by John Doe on 2022-06-10.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "\(product?.id ?? 0)"
       
        descLabel.text = product?.productDescription
        downloadImage(from: URL(string: product?.image?.url ?? "https://www.dmplayhouse.com/wp-content/uploads/2019/12/13-512.png")!)
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

   
    

}

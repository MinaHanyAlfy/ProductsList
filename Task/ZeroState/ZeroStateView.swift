//
//  ZeroStateViewController.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import UIKit

class ZeroStateView: UIView {
    private let label :UILabel = {
        let label = UILabel()
        label.text = "There's No Products, Check Connection and reOpen app."
        label.tintColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bell")
        return imageView
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
      
        imageView.frame = CGRect(x: (width-100)/2, y: 0, width: 100, height: 100).integral
        label.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height-100).integral
    
    }

    

   

}

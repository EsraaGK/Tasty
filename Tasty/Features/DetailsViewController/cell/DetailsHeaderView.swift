//
//  DetailsHeaderView.swift
//  Tasty
//
//  Created by EsraaGK on 4/2/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit
import SafariServices

class DetailsHeaderView: UIView {
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var titleLable: UILabel!
    var parentViewController: UIViewController?
    var sourceUrl: String?
    
    @IBAction func visitSource(_ sender: Any) {
        if let url = URL(string: sourceUrl ?? "") {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let vc = SFSafariViewController(url: url, configuration: config)
                parentViewController?.present(vc, animated: true)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
        func configureHeaderView(imgUrlString: String, title: String ) {
            titleLable.text = title
            recipeImage.setImageWith(urlString: imgUrlString)
            addGradient()
        }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ UIColor.clear.cgColor,
                                 UIColor.clear.cgColor,
                                 UIColor.black.cgColor,
                                 UIColor.black.cgColor]
        gradientLayer.locations = [0, 0.3, 0.7, 1]
       gradientLayer.frame = recipeImage.frame
        gradientLayer.opacity = 0.9
       recipeImage.layer.addSublayer(gradientLayer)
    }

    }
    extension DetailsHeaderView {
        static var identifire: String { return String(describing: self) }
        static var nib: UINib { return UINib(nibName: DetailsHeaderView.identifire, bundle: nil) }
}

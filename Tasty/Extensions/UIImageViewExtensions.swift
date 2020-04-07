//
//  UIImageExtensions.swift
//  Tasty
//
//  Created by EsraaGK on 4/3/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWith(urlString: String) {
        
        let url = URL(string: urlString)
        self.kf.setImage(with: url, placeholder: Asset.placeholder.image)
        
    }
}

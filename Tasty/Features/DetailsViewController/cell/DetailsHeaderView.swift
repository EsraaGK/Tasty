//
//  DetailsHeaderView.swift
//  Tasty
//
//  Created by EsraaGK on 4/2/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class DetailsHeaderView: UIView {
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBAction func visitSource(_ sender: Any) {
    }
    
    func configureHeaderView(imgUrlString: String, title: String ) {
        titleLable.text = title
        recipeImage.setImageWith(urlString: imgUrlString)
    }
}
extension DetailsHeaderView {
    static var identifire: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: DetailsHeaderView.identifire, bundle: nil) }
}

//
//  SearchDataTableViewCell.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class SearchDataTableViewCell: UITableViewCell {
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var recipeTitleLable: UILabel!
    @IBOutlet private weak var sourceLable: UILabel!
    @IBOutlet private weak var healthLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension SearchDataTableViewCell {
    static var identifire: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: SearchDataTableViewCell.identifire, bundle: nil) }
}

//
//  DetailsTableViewCell.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension DetailsTableViewCell {
    static var identifire: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: DetailsTableViewCell.identifire, bundle: nil) }
}

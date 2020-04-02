//
//  DteailsTableViewHeader.swift
//  Tasty
//
//  Created by EsraaGK on 4/2/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class DetailsTableViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak private var image: UIImage!


}

extension DetailsTableViewHeader {
    static var identifire: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: DetailsTableViewHeader.identifire, bundle: nil) }
}

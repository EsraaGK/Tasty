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
    @IBOutlet private weak var backGroungView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.9572720462, green: 0.8271618151, blue: 0.3491812928, alpha: 1)
//            //Asset.backGround.color
//        backgroundView? = UIView()
    }
   
    func configureSearchDataCell(with recipe: Recipe) {
        backGroungView.addShadowAndCornerRadius()
        recipeImage.setImageWith(urlString: recipe.image)
        recipeTitleLable.text = recipe.label
        sourceLable.text = recipe.source
        healthLable.text = concat(array: recipe.healthLabels ?? [String]())
        
    }
    func concat(array: [String]) -> String {
          var string = ""
          for item in array {
              string += item
          }
          return string
      }
}

extension SearchDataTableViewCell {
    static var identifire: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: SearchDataTableViewCell.identifire, bundle: nil) }
}

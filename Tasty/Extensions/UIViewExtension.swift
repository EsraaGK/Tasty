//
//  StringExtension.swift
//  Tasty
//
//  Created by EsraaGK on 4/4/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

extension UIView {
    func addShadowAndCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        if #available(iOS 10.0, *) {
            self.layer.shadowColor = UIColor(ciColor: .gray).cgColor
        } else {
            // Fallback on earlier versions
        }
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
       // self.backgroundColor = UIColor(named: "Red")
    }
    
      func loadViewFromNib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      }
    
}

extension UIImage {
    
}

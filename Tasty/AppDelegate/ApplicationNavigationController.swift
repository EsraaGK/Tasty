//
//  ApplicationNavigationController.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class ApplicationNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(),
                                              for: UIBarPosition.any,
                                              barMetrics: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = #colorLiteral(red: 0.950938046, green: 0.820579946, blue: 0.3441214561, alpha: 1)
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black];
    }
}

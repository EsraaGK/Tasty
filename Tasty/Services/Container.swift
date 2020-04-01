//
//  Container.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class Container {
   
    class func getSearchScene() -> SearchViewController {
        return  SearchViewControllerModule.getSearchViewController()
    }
    
}

//
//  SearchViewControllerModule.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class DetailsViewControllerModule {
 
    class func getDetailsViewController() -> DetailsViewController {
        let view = DetailsViewController()
        let model = DetailsModel()
        let presenter = DetailsPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}

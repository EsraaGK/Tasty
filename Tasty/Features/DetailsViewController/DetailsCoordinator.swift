//
//  SearchCoordinator.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class DetailsCoordinator: Coordinator {
    private var presenter: UINavigationController
    private var detailsViewController: DetailsViewController?
    
    init(presenter: UINavigationController, recipe: Recipe) {
        self.presenter = presenter
        detailsViewController = getDetailsViewController(recipe: recipe)
    }
    
    func start() {
        presenter.pushViewController(detailsViewController ?? DetailsViewController(), animated: true)
    }
    
    func getDetailsViewController(recipe: Recipe) -> DetailsViewController {
        let view = DetailsViewController()
        let model = DetailsModel()
        let presenter = DetailsPresenter(view: view, model: model, recipe: recipe)
        view.presenter = presenter
        return view
    }
}

extension DetailsCoordinator: DetailsViewControllerDelegate {
}

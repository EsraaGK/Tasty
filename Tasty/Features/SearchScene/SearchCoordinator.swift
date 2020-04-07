//
//  SearchCoordinator.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    private var presenter: UINavigationController
    private var searchViewController: SearchViewController?
    private var detailsCoordinator: DetailsCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        searchViewController = getSearchViewController()
//        searchViewController?.delegate = self
    }
    
    func start() {
        presenter.pushViewController(searchViewController ?? SearchViewController(), animated: true)
    }
    func getSearchViewController() -> SearchViewController {
           let view = SearchViewController()
           let model = SearchModel()
           let presenter = SearchPresenter(view: view, model: model)
           presenter.moveToDetailsDelegate = self
           view.presenter = presenter
           return view
       }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func moveToDetails(recipe: Recipe) {
        detailsCoordinator = DetailsCoordinator(presenter: presenter, recipe: recipe)
        detailsCoordinator?.start()
    }
}

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
        searchViewController = Container.getSearchScene()
        searchViewController?.delegate = self
    }
    
    func start() {
        presenter.pushViewController(searchViewController ?? SearchViewController(), animated: true)
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func moveToDetails() {
        detailsCoordinator = DetailsCoordinator(presenter: presenter)
        detailsCoordinator?.start()
    }
}

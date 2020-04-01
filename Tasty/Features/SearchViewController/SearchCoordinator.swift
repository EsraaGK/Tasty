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
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        searchViewController = Container.getSearchScene()
    }
    
    func start() {
        presenter.pushViewController(searchViewController ?? SearchViewController(), animated: true)
    }
}

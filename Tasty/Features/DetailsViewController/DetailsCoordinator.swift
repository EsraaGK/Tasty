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
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        detailsViewController = Container.getDetailsScene()
    }
    
    func start() {
        presenter.pushViewController(detailsViewController ?? DetailsViewController(), animated: true)
    }
}

extension DetailsCoordinator: DetailsViewControllerDelegate {
}

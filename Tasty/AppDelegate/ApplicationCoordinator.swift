//
//  ApplicationCoordinator.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    private var window: UIWindow
    private var presenter: UINavigationController?
    private var searchCoordinator: SearchCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        presenter = ApplicationNavigationController()//UINavigationController()
        searchCoordinator = SearchCoordinator(presenter: presenter ?? UINavigationController())
    }
    
    func start() {
        window.rootViewController = presenter
        searchCoordinator?.start()
        window.makeKeyAndVisible()
    }
}

//
//  AppManger.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit
import Moya

class AppManger {
    static let shared = AppManger()
    let userDefaults = UserDefaults.standard
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?
    var apiService = MoyaProvider<EdamamServices>()
    init() {
    }
    
    static func launchApp() {
        if #available(iOS 13, *) {
            //Scene Delegate will call  initWindow(windowScene: UIWindowScene)
        } else {
            initWindow()
        }
    }
    
    static func initWindow() {
        AppManger.shared.window = UIWindow(frame: UIScreen.main.bounds)
        startAppCoordinator()
    }
    
    @available(iOS 13.0, *)
    static  func initWindowWithScene(windowScene: UIWindowScene) {
        AppManger.shared.window = UIWindow(windowScene: windowScene)
        startAppCoordinator()
    }
    static func startAppCoordinator() {
        AppManger.shared.applicationCoordinator = ApplicationCoordinator(
            window: AppManger.shared.window ?? UIWindow())
        AppManger.shared.applicationCoordinator?.start()
    }
}

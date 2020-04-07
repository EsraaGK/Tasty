//
//  UIViewControllerExtensions.swift
//  Tasty
//
//  Created by EsraaGK on 4/3/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSpinner(onView: UIView) -> UIView {
        let window = UIApplication.shared.keyWindow
        let spinnerView = UIView(frame: window?.bounds ?? UIScreen.main.bounds)
           spinnerView.backgroundColor = #colorLiteral(red: 0.8302921661, green: 0.9086847175, blue: 0.9179955051, alpha: 0.496869649)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
           activityIndicator.startAnimating()
           activityIndicator.center = spinnerView.center
           
           DispatchQueue.main.async {
               spinnerView.addSubview(activityIndicator)
            window?.addSubview(spinnerView);
           }
           return spinnerView
       }
       
       func removeSpinner(spinnerView: UIView) {
           DispatchQueue.main.async {
               spinnerView.removeFromSuperview()
           }
       }
}

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
           let spinnerView = UIView(frame: onView.bounds)
           spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
           activityIndicator.startAnimating()
           activityIndicator.center = spinnerView.center
           
           DispatchQueue.main.async {
               spinnerView.addSubview(activityIndicator)
               onView.addSubview(spinnerView)
           }
           return spinnerView
       }
       
       func removeSpinner(spinnerView: UIView) {
           DispatchQueue.main.async {
               spinnerView.removeFromSuperview()
           }
       }
}

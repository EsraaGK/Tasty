//
//  StringExtension.swift
//  Tasty
//
//  Created by EsraaGK on 4/4/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

extension UIView {
    func addShadowAndCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        if #available(iOS 10.0, *) {
            self.layer.shadowColor = UIColor(ciColor: .gray).cgColor
        } else {
            // Fallback on earlier versions
        }
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
       // self.backgroundColor = UIColor(named: "Red")
    }
    
      func loadViewFromNib() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      }
    
}

extension UIImage {
    
}
extension UIView {
    
    func animateHeartbeating() {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        
        animation.duration = 0.25
        
        animation.fromValue = 1.0
        animation.toValue = 1.25
        
        animation.autoreverses = true
        
        animation.initialVelocity = 0.5
        animation.damping = 0.8
        
        self.layer.add(animation, forKey: "beating")
    }
    
    func animateShakeing() {
        
        let animation = CASpringAnimation(keyPath: "transform.translation.x")
        
        animation.fromValue = 0
        animation.toValue = 10
        
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        
        animation.initialVelocity = 0.0
        animation.damping = 0.5
        
        self.layer.add(animation, forKey: "shaking")
    }
    
    var isHiddenIfNeeded: Bool {
        get {
            return self.isHidden
        }
        set {
            if self.isHidden != newValue {
                self.isHidden = newValue
            }
        }
    }
    
    func hideAnimated( completion: (() -> Void)? = nil ) {
        
        if self.isHidden { return }
        if self.superview is UIStackView {
            UIView.animate(withDuration: 0.25, animations: {
                self.isHidden = true
            }, completion: { _ in
                completion?()
            })
            return
        }
        
        self.alpha = 1
        self.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.alpha = 1
            self.isHidden = true
            completion?()
        })
    }
    
    func showupAnimated(_ completion:(() -> Void)? = nil) {
        
        if !self.isHidden { return }
        if self.superview is UIStackView {
            UIView.animate(withDuration: 0.25, animations: {
                self.isHidden = false
            }, completion: { _ in
                completion?()
            })
            return
        }
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }
    
    var width: CGFloat {
        return self.bounds.width
    }
    
    var height: CGFloat {
        return self.bounds.height
    }
    
    func loadFromNib(addConstrains: Bool) {
        
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                                  owner: self,
                                                  options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        if addConstrains {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.topAnchor.constraint(equalTo: view.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        }
    }
    
    func addPrimaryShadow() {
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1.0
    }
    
    func setTransformFullBottom() {
        self.transform = CGAffineTransform(translationX: 0, y: self.bounds.maxY)
    }
    
    func setTransformFullTop() {
        self.transform = CGAffineTransform(translationX: 0, y: -self.bounds.maxY)
    }
    
    func setTransformIdentity() {
        self.transform = CGAffineTransform.identity
    }
}

extension UITextView {
    
    func trim() -> UITextView {
        self.text = self.text?.trim()
        return self
    }
    
    var isEmpty: Bool {
        return (self.text ?? "").isEmpty
    }
}

extension UITextField {
    
    func trim() -> UITextField {
        self.text = self.text?.trim()
        return self
    }
    
    var isEmpty: Bool {
        return (self.text ?? "").isEmpty
    }
}

//
//  BundleExtensions.swift
//  Tasty
//
//  Created by EsraaGK on 4/2/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}

//
//  StringExtension.swift
//  Tasty
//
//  Created by EsraaGK on 4/4/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

extension Array {
    func concatArray() -> String {
        var string = ""
        for item in self {
            string = "\(item)"
        }
        return string
    }
}

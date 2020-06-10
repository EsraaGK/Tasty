//
//  StringExtension.swift
//  Tasty
//
//  Created by EsraaGK on 6/10/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//


import Foundation
import UIKit

enum StringPattern: Int {
    
    case email = 0
    case mobile = 1
    case numbersOnly = 2
    case lettersOnly = 3
}

extension String {
    
    func toOneLineString() -> String {
        return self.replacingOccurrences(of: "\n", with: " ")
    }
    
    func validate(forPattern patternType: StringPattern) -> Bool {
        
        if self.trim().isEmpty {
            return false
        }
        
        if patternType == StringPattern.email {
            
            let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            
            return emailTest.evaluate(with: self)
        }
        
        if patternType == StringPattern.numbersOnly {
            
            return self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
        
        if patternType == StringPattern.lettersOnly {
            
            return self.replacingOccurrences(of: " ", with: "")
                .rangeOfCharacter(from: CharacterSet.letters.inverted) == nil
        }
        
        if patternType == StringPattern.mobile {
            
            return self.replacingOccurrences(of: "+", with: "").validate( forPattern: .numbersOnly)
        }
        
        return false
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func width (font: UIFont, constrainedToHeight height: Double) -> CGFloat {
        return NSString(string: self)
            .boundingRect( with: CGSize(width: .greatestFiniteMagnitude, height: height),
                           options: .usesLineFragmentOrigin,
                           attributes: [.font: font],
                           context: nil).size.width
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func toArabicNumbers() -> String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $1, with: $0) }
        return str
    }
    
    func toEnglishNumbers() -> String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    func containsNumber() -> Bool {
        return self.toEnglishNumbers().rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }
    
    func containsLetter() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.letters) != nil
    }
    
    func fromBase64() -> String? {
        
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    var fullRange: NSRange {
        return NSRange(location: 0, length: self.count)
    }
    
//    func toURLString(_ baseUrl: String = Configuration.baseURL) -> String? {
//        
//        if self.isEmpty {
//            return nil
//        }
//        
//        if !self.contains("http") {
//            return baseUrl + self
//        }
//        
//        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
//    }
//  
  func strikethrough() -> NSAttributedString {
     let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
     attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                  value: 1,
                                  range: NSRange(0..<self.count))
     attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                  value: UIColor(),
                                  range: NSRange(0..<self.count))
     return attributeString
   }
   
   func toDouble() -> Double? {
     return NumberFormatter().number(from: self)?.doubleValue
   }
}


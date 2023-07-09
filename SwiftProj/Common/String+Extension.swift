//
//  String+Extension.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/01/08.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func getBase64Encoding() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        let ret = data.base64EncodedString()
        
        return ret
    }
    
    func getBase64Decoding() -> String {
        let data = Data(base64Encoded: self)!
        let ret = String(data: data, encoding: .utf8)!
        
        return ret
    }
    
    func getURLEncoding() -> String {
        let ret = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
        
        return ret
    }
    
    func getURLDecdoing() -> String {
        let ret = self.removingPercentEncoding!
        
        return ret
    }
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
        /*
        //Localizable.strings (English)
        "My Age %d" = "I am %d years old";
        //Localizable.strings (Japanese)
        "My Age %d" = "私は%d歳だよ。";
        //Localizable.strings (Korean)
        "My Age %d" = "나의 나이 %d";
        */
        
        return String(format: self.localized(comment: comment), argument)
    }

    func localizeString() -> String {
        
        let userDefault = UserDefaults.standard
        let lang = userDefault.string(forKey: "lang") ?? "ko"
        
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: "name", bundle: bundle!, value: "", comment: "")
        }
        
        return self
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}

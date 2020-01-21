//
//  NSAttributeString+.swift
//  NetworkPlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation

extension NSAttributedString {

internal convenience init?(html: String) {
    guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
        return nil
    }

    guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
        return nil
    }

    self.init(attributedString: attributedString)
}
}

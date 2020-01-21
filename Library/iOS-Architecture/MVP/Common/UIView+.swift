//
//  UIVIew+.swift
//  NetworkPlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit

extension UIView {
    public func addSubviews(views: UIView...) {
        views.forEach { self.addSubview($0) } 
    }
}


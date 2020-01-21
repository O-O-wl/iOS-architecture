//
//  Response.swift
//  NetworkPlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation
import Domain

extension Network {
    struct Response: Codable {
        let lastBuildDate: String
        let total: Int
        let start: Int
        let display: Int
        let items: [Book]
    }
}

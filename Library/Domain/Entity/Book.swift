//
//  Book.swift
//  Domain
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation

public struct Book: Codable {
    public let title: String
    public let imageURL: String
    public let author: String
    public let price: String
    public let discount: String?
    public let publisher: String
    public let publicationDate: String
    public let isbn: String
    public let description: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image"
        case author
        case price
        case discount
        case publisher
        case publicationDate = "pubdate"
        case isbn
        case description
    }
}

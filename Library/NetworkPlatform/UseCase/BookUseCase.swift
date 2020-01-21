//
//  BookUseCase.swift
//  NetworkPlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation
import Domain

open class BookUseCase: Domain.BookUseCase {
    public func get(completion: @escaping (Result<[Book], Swift.Error>) -> Void) {
        completion(.failure(BookUseCase.Error.invaildRequest))
    }
    
    public func get(with query: String, completion: @escaping (Result<[Book], Swift.Error>) -> Void) {
        Network.default.request(with: query, completion: completion)
    }
    
    public func save(book: Book, completion: @escaping (Result<Void, Swift.Error>) -> Void) {
        completion(.failure(BookUseCase.Error.invaildRequest))
    }
    
    public func delete(completion: @escaping (Result<Void, Swift.Error>) -> Void) {
        completion(.failure(BookUseCase.Error.invaildRequest))
    }
    
    enum Error: Swift.Error {
        case invaildRequest
    }
    
}

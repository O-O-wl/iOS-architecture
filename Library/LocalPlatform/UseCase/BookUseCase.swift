//
//  BookUseCase.swift
//  LocalStoragePlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation
import Domain

public class BookUseCase: Domain.BookUseCase {
    public func get(completion: @escaping (Result<[Book], Swift.Error>) -> Void) {
        LocalStorage.shared.get(completion: completion)
    }
    
    public func get(with query: String, completion: @escaping (Result<[Book], Swift.Error>) -> Void) {
        completion(.failure(BookUseCase.Error.invaildRequest))
    }
    
    public func save(book: Book, completion: @escaping (Result<Void, Swift.Error>) -> Void) {
        LocalStorage.shared.save(book: book, completion: completion)
    }
    
    public func delete(book: Book, completion: @escaping (Result<Void, Swift.Error>) -> Void) {
        LocalStorage.shared.delete(book: book, completion: completion)
    }
    
    enum Error: Swift.Error {
        case invaildRequest
    }
}

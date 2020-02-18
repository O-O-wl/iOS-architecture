//
//  BookUseCase.swift
//  Domain
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation
import RxSwift

public protocol BookUseCase {
    func get(completion: @escaping (Result<[Book], Error>) -> Void)
    func get(with query: String, completion: @escaping (Result<[Book], Error>) -> Void)
    func save(book: Book, completion: @escaping (Result<Void, Error>) -> Void)
    func delete(book: Book, completion: @escaping (Result<Void ,Error>) -> Void)
}

public protocol ReactiveBookUseCase {
    func get() -> Single<[Book]>
    func get(with query: String) -> Single<[Book]>
    func save(book: Book) -> Completable
    func delete(book: Book) -> Completable
}

//
//  LocalStorage.swift
//  LocalStoragePlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import Foundation
import Domain

class LocalStorage {
    static var fileURL: URL {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "favoriteBooks"
        return documentURL.appendingPathComponent(fileName)
    }
    
    static let shared = LocalStorage()
    
    private var books: Set<Book> = []
    
    func get(completion: @escaping (Result<[Book], Error>) -> Void) {
        do {
            let data = try Data(contentsOf: LocalStorage.fileURL)
            let books = try JSONDecoder().decode([Book].self, from: data)
            self.books = Set<Book>(books)
            completion(.success(books))
        } catch {
            completion(.failure(error))
        }
    }
    
    func save(book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        books.insert(book)
        write(completion: completion)
    }
    
    func delete(book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        books = books.filter { $0 != book }
        write(completion: completion)
    }
    
    private func write(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: LocalStorage.fileURL)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
}

//
//  BooksPresenter.swift
//  MVC
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain

protocol BookView: AnyObject {
    var favoriteButtonDidTap: ((Bool) -> Void)? { get set }
    func display(title: NSAttributedString?)
    func display(author: NSAttributedString?)
    func display(price: String?)
    func display(image: UIImage?)
}

protocol BooksView: AnyObject {
    func refresh()
    func showAlert(message: String)
}

protocol BooksPresenter {
    var numberOfBooks: Int { get }
    func configure(bookView: BookView, at index: Int)
    func search(with query: String)
}

class BooksPresenterImplementation: BooksPresenter {
    
    // MARK: - Dependencies
    
    private unowned let view: BooksView
    private let networkUseCase: Domain.BookUseCase
    private let localUseCase: Domain.BookUseCase
    
    // MARK: - Properties
    
    private var books: [Book] = []
    
    var numberOfBooks: Int {
        return books.count
    }
    
    // MARK: - Initialization
    
    init(view: BooksView,
         networkUseCase: Domain.BookUseCase,
         localUseCase: Domain.BookUseCase) {
        self.view = view
        self.networkUseCase = networkUseCase
        self.localUseCase = localUseCase
    }
    
    // MARK: - Methods
    
    func configure(bookView: BookView, at index: Int) {
        guard index < books.count else { return }
        
        let book = books[index]
        
        bookView.display(title: NSAttributedString(html: book.title))
        bookView.display(author: NSAttributedString(html: book.author))
        bookView.display(price: book.price)
        bookView.favoriteButtonDidTap = { isFavorite in
            self.favorite(isFavorite, book: book)
        }
        
        guard let url = URL(string: book.imageURL) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
                else { return }
            
            bookView.display(image: image)
        }
        
    }
    
    func search(with query: String) {
        networkUseCase.get(with: query) { result in
            switch result {
            case .success(let books):
                self.books = books
                self.view.refresh()
            case .failure(let error):
                self.view.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func favorite(_ isFavorite: Bool, book: Book) {
        if isFavorite {
            localUseCase.save(book: book) { result in
                switch result {
                case .success(_):
                    self.view.showAlert(message: "찜")
                case .failure(let error):
                    self.view.showAlert(message: error.localizedDescription)
                }
            }
        } else {
            localUseCase.delete(book: book) { result in
                switch result {
                case .success(_):
                    self.view.showAlert(message: "찜 취소")
                case .failure(let error):
                    self.view.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
}

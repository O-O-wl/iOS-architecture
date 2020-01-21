//
//  FavoriteBooksViewController.swift
//  MVC
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import SnapKit
import Then

class FavoriteBooksViewController: BaseViewController{
    
    // MARK: - Dependencies
    
    var favoriteBookUseCase: Domain.BookUseCase?
    
    // MARK: - UI
    
    private let booksTableView = UITableView()
    
    
    // MARK: - Properties
    
    private var books: [Book] = []
    
    // MARK: - Initialization
    
    override func initialize() {
        super.initialize()
        
        fetchBooks()
    }
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchBooks()
    }
    
    // MARK: - Layouts
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubviews(views: booksTableView)
        
        
        booksTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Attributes
    
    override func setupAttribute() {
        super.setupAttribute()
        
        
        booksTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.rowHeight = 150
            $0.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseIdentifier)
        }
    }
    
    // MARK: - Methods
    
    private func fetchBooks() {
        favoriteBookUseCase?.get() { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books
                self?.display()
            case .failure(let error):
                self?.alert(message: error.localizedDescription)
            }
        }
    }
    
    private func alert(message: String) {
        DispatchQueue.main.async {
            UIAlertController(title: nil,
                              message: message,
                              preferredStyle: .alert)
                .do {
                    $0.addAction(.init(title: "확인", style: .default, handler: nil))
                    self.present($0, animated: true, completion: nil)
            }
        }
    }
    
    private func display() {
        DispatchQueue.main.async {
            self.booksTableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDataSource

extension FavoriteBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseIdentifier,
                                                       for: indexPath) as? BookCell
            else { return BookCell() }
        let book = books[indexPath.row]
        cell.configure(book)
        // FIXME: - 로직 분리 고려
        
        cell.favoriteButtonDidTap = { _ in
            self.favoriteBookUseCase?.delete(book: book) { _ in
                self.alert(message: "삭제 완료")
                self.books.remove(at: indexPath.row)
                self.display()
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoriteBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

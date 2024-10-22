//
//  ViewController.swift
//  Library
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import SnapKit
import Then

class BooksViewController: BaseViewController{
    
    // MARK: - Dependencies
    
    var bookUseCase: Domain.BookUseCase?
    var favoriteBookUseCase: Domain.BookUseCase?
    
    // MARK: - UI
    
    private let searchBar = UISearchBar()
    private let booksTableView = UITableView()
    
    
    // MARK: - Properties
    
    private var books: [Book] = []
    
    // MARK: - Initialization
    
    
    // MARK: - Layouts
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubviews(views: searchBar, booksTableView)
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        booksTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Attributes
    
    override func setupAttribute() {
        super.setupAttribute()
        
        searchBar.delegate = self
        
        booksTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.rowHeight = 150
            $0.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseIdentifier)
        }
    }
    
    // MARK: - Methods
    
    private func fetchBooks(with query: String) {
        bookUseCase?.get(with: query) { [weak self] result in
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

// MARK: - UISearchBarDelegate

extension BooksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        fetchBooks(with: query)
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension BooksViewController: UITableViewDataSource {
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
        cell.favoriteButtonDidTap = { favorite in
            switch favorite {
            case true: self.favoriteBookUseCase?.save(book: book) { result in
                switch result {
                case .success(_):
                    self.alert(message: "저장 완료")
                case .failure(let error):
                    self.alert(message: error.localizedDescription)
                }
                }
            case false: self.favoriteBookUseCase?.delete(book: book) { result in
                switch result {
                case .success(_):
                    self.alert(message: "삭제 완료")
                case .failure(let error):
                    self.alert(message: error.localizedDescription)
                }
                }
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

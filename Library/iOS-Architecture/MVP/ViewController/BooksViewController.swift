//
//  ViewController.swift
//  MVP
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import SnapKit
import Then

class BooksViewController: BaseViewController, BooksView {
    
    // MARK: - Dependencies
    
    var presenter: BooksPresenter?
    
    // MARK: - UI
    
    private let searchBar = UISearchBar()
    private let booksTableView = UITableView()
    
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
    
    func refresh() {
        DispatchQueue.main.async {
            self.booksTableView.reloadData()
        }
    }
    
    func showAlert(message: String) {
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
}

// MARK: - UISearchBarDelegate

extension BooksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        presenter?.search(with: query)
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfBooks ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseIdentifier,
                                                       for: indexPath) as? BookCell
            else { return BookCell() }
        
        presenter?.configure(bookView: cell, at: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


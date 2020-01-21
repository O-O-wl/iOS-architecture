//
//  FavoriteBooksViewController.swift
//  MVC
//
//  Created by 이동영 on 2020/01/22.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import SnapKit
import Then

class FavoriteBooksViewController: BaseViewController, FavoriteBooksView {
    
    // MARK: - Dependencies
    
    var presenter: FavoriteBooksPresenter?
    
    // MARK: - UI
    
    private let booksTableView = UITableView()
    
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.loadData()
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
    
    private func request() {
        presenter?.loadData()
    }
    
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

// MARK: - UITableViewDataSource

extension FavoriteBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfFavoriteBooks ?? 0
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

extension FavoriteBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

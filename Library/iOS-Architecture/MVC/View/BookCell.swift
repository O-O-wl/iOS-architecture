//
//  BookCell.swift
//  NetworkPlatform
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import SnapKit
import Then

public class BookCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - UI
    
    private let bookImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let authorLabel = UILabel()
    
    // MARK: - Initialization
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
        setupAttribute()
    }
    
    // MARK: - Layouts
    
    private func setupLayout() {
        self.addSubviews(views: bookImageView, titleLabel, priceLabel, authorLabel)
        
        bookImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(bookImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(10)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(10)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(10)
        }
    }
    
    // MARK: - Attributes
    
    private func setupAttribute() {
        titleLabel.do {
            $0.numberOfLines = 0
        }
        
        authorLabel.do {
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .gray
        }
        
        priceLabel.do {
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = #colorLiteral(red: 0.401716995, green: 0.7132051952, blue: 1, alpha: 1)
        }
        
        bookImageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func configure(_ book: Book) {
        if let imageURL = URL(string: book.imageURL) {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: imageURL) else { return }
                DispatchQueue.main.async {
                    self.bookImageView.image = UIImage(data: data)
                }
            }
        }
        titleLabel.attributedText = NSAttributedString(html: book.title)
        authorLabel.text = book.author
        priceLabel.text = book.price
    }
}

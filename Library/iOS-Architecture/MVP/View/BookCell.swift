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
    static let filledHeart = UIImage(systemName: "heart.fill")!
    static let emptyHeart = UIImage(systemName: "heart")!
    
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - UI
    
    private let bookImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let authorLabel = UILabel()
    private let favoriteImageView = UIImageView()
    
    // MARK: - Closure
    
    var favoriteButtonDidTap: ((Bool) -> Void)?
    
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
        self.addSubviews(views: bookImageView, titleLabel, priceLabel, authorLabel, favoriteImageView)
        
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
        
        favoriteImageView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.top).offset(5)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(35)
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
        
        favoriteImageView.do {
            $0.image = BookCell.emptyHeart
            $0.isUserInteractionEnabled = true
            $0.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favorite)))
        }
    }
    
    @objc
    func favorite() {
        var favorite = favoriteImageView.image == BookCell.filledHeart
        favorite.toggle()
        favoriteImageView.image = favorite ? BookCell.filledHeart : BookCell.emptyHeart
        self.favoriteButtonDidTap?(favorite)
    }
}

extension BookCell: BookView {
    func display(title: NSAttributedString?) {
        DispatchQueue.main.async {
            self.titleLabel.attributedText = title
        }
    }
    
    func display(author: NSAttributedString?) {
        DispatchQueue.main.async {
            self.authorLabel.attributedText = author
        }
    }
    
    func display(price: String?) {
        DispatchQueue.main.async {
            self.priceLabel.text = price
        }
    }
    
    func display(image: UIImage?) {
        DispatchQueue.main.async {
            self.imageView?.image = image
        }
    }
    
}

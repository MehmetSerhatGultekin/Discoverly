//
//  FavoritesCell.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 22.07.2025.
//

import UIKit

final class FavoritesCell: UITableViewCell {
    
    // MARK: Properties
    
    private let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
      let label = UILabel()
        label.font = UIFont.systemFont(ofSize:12, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize:16, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesCell {
    func configure(with content: Content) {
        titleLabel.text = content.title
        categoryLabel.text = content.category

        if let posterPath = content.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.posterImageView.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.posterImageView.image = UIImage(systemName: "photo")
                        }
                    }
                }.resume()
            }
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
    }
}

extension FavoritesCell {
    private func configureViews() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 60),
            posterImageView.heightAnchor.constraint(equalToConstant: 90),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            
            categoryLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            categoryLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor)
        ])
    }
}

//
//  DetailView.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 16.07.2025.
//
import UIKit

class DetailView: UIView {
   
    var content: Content?
    
     // MARK: Properties
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}


extension DetailView {
    private func configureViews() {
        backgroundColor = UIColor(red: 240/255, green: 248/255, blue: 255/255, alpha: 1) // AliceBlue
        
        addSubViews()
        setupConstraints()
       
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            ratingLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    private func addSubViews() {
        addSubview(posterImageView)
        addSubview(ratingLabel)
        addSubview(overviewLabel)
        
    }
    
    func set(content: Content) {
            ratingLabel.text = "IMDB: \(String(format: "%.1f", content.voteAverage))"
            overviewLabel.text = content.overview
            if let posterPath = content.posterPath {
                let imageUrlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
                if let imageUrl = URL(string: imageUrlString) {
                    URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                        if let data = data {
                            DispatchQueue.main.async {
                                UIView.transition(with: self.posterImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                                    self.posterImageView.image = UIImage(data: data)
                                })
                            }
                        }
                    }.resume()
                }
            }
        }
}

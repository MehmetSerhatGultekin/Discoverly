//
//  DetailViewController.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
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
    
    // MARK: Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

extension DetailViewController {
    private func setupViews() {
        view.backgroundColor = UIColor(red: 240/255, green: 248/255, blue: 255/255, alpha: 1) // AliceBlue
        
        // Enable large titles for navigation bar
        // navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        view.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.view.alpha = 1
        }

        
        addSubViews()
        setupConstraints()
        configure()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            ratingLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private func addSubViews() {
        view.addSubview(posterImageView)
        view.addSubview(ratingLabel)
        view.addSubview(overviewLabel)
    }
    
    private func configure() {
        guard let content = content else { return }
        //Set navigationItem.title as usual; large titles will allow for more space
        self.navigationItem.title = content.title
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

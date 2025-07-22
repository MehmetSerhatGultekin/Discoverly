//
//  DetailViewController.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//

import UIKit

final class DetailViewController: UIViewController {

    var content: Content?
    private var heartButton: UIButton?

    // MARK: Lifecycles
    
    override func loadView() {
        view = DetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = true
        configure()
    }

    private func configure() {
        guard let content = content, let detailView = view as? DetailView else { return }
        self.navigationItem.title = content.title
        detailView.set(content: content)

        heartButton = detailView.heartButton
        heartButton?.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)

        updateHeartIcon()
    }

    @objc private func toggleFavorite() {
        guard let content = content else { return }
        if FavoritesManager.shared.isFavorite(content) {
            FavoritesManager.shared.removeFromFavorites(content)
        } else {
            FavoritesManager.shared.addToFavorites(content)
        }
        updateHeartIcon()
    }

    private func updateHeartIcon() {
        guard let content = content else { return }
        let imageName = FavoritesManager.shared.isFavorite(content) ? "heart.fill" : "heart"
        heartButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

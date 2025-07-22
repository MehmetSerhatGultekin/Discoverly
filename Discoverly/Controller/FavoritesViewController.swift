//
//  FavoritesViewController.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 22.07.2025.
//

import UIKit

final class FavoritesViewController: UIViewController {

    private var favorites: [Content] = []

    override func loadView() {
        self.view = FavoritesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let favoritesView = view as? FavoritesView else { return }
        let tableView = favoritesView.tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: Constants.Identifiers.favoritesCellIdentifier)

        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: .favoritesUpdated, object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Delete All",
            style: .plain,
            target: self,
            action: #selector(deleteAllTapped)
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let favoritesView = view as? FavoritesView else { return }
        favorites = FavoritesManager.shared.getAllfavorites()
        favoritesView.tableView.reloadData()
        
        print("Favori sayısı: \(favorites.count)")
    }

    @objc private func reloadFavorites() {
        guard let favoritesView = view as? FavoritesView else { return }
        favorites = FavoritesManager.shared.getAllfavorites()
        favoritesView.tableView.reloadData()
    }
    
    
    @objc private func deleteAllTapped() {
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "This will remove all your favorites.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            FavoritesManager.shared.clearAllFavorites()
            self.reloadFavorites()
        }))
        
        present(alert, animated: true, completion: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesUpdated, object: nil)
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.favoritesCellIdentifier, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        let content = favorites[indexPath.row]
        cell.configure(with: content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContent = favorites[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.content = selectedContent
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

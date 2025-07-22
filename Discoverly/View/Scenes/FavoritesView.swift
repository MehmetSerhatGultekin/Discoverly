//
//  FavoritesView.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 22.07.2025.
//

import UIKit

final class FavoritesView: UIView {
    
    // MARK: Properties
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .singleLine // hücreler arasına çizgi koyuldu
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesView {
   private func configureViews() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
       addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                   tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                   tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                   tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
               ])
    }
}

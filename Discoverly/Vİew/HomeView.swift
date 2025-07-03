//
//  HomeView.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//
import UIKit

class HomeView: UIView {
   
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discoverly"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() // Bu, koleksiyon görünümünün hücreleri nasıl yerleştireceğini belirleyen bir düzenleyicidir. Yani: Hücreler satır satır mı dizilsin, yoksa tek satırda yatay mı olsun?
        layout.scrollDirection = .horizontal // Varsayılan olarak CollectionView dikey kayar. Ama burada kategori seçimi gibi yatay bir görünüm istediğimiz için .horizontal olarak ayarlanır.
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .init(width: 70, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // frame: .zero demek: “Ben boyutunu constraint’lerle ayarlayacağım”.
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public let contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Enhance UI: Add background color and remove separators
        tableView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1) // GhostWhite
        tableView.separatorStyle = .none
        // Optionally: Add rounded corners for a softer look
        tableView.layer.cornerRadius = 0
        tableView.layer.masksToBounds = true
        tableView.rowHeight = 100
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorInset = .zero
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(categoryCollectionView)
        addSubview(contentTableView)

        NSLayoutConstraint.activate([
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            // categoryCollectionView constraints
            categoryCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            categoryCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 80),
            // contentTableView constraints
            contentTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 8),
            contentTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

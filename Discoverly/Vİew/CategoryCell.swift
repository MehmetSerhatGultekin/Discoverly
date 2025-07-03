//
//  Categorycell.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//

import UIKit

class Categorycell: UICollectionViewCell {
    
    public let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAppearance(isSelected: Bool) {
        if isSelected {
            backgroundColor = .black
            categoryLabel.textColor = .white
            layer.borderWidth = 0
        } else {
            backgroundColor = .systemGray6
            categoryLabel.textColor = .black
            layer.borderWidth = 1
            layer.borderColor = UIColor.systemGray4.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        clipsToBounds = true
    }
}

/*
 GENEL NOTLAR
 
 1.PADDING NEDİR
 Padding, bir öğenin (örneğin bir yazı, buton ya da label) içindeki içerikle kenarları arasındaki boşluktur.
 Diyelim ki bir kutu çiziyorsun (örneğin UILabel) ve içine “Kitaplar” yazıyorsun.
     •    Padding, “Kitaplar” yazısının kutunun kenarlarına ne kadar uzak olacağını belirler.
 Yani yazının kutuya yapışık mı, ortalanmış mı yoksa boşluklu mu duracağını kontrol eder.
 */

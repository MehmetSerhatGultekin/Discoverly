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
        
        layout()
    }
    
    private func layout() {
        contentView.addSubview(categoryLabel)
        
        let heightConstraint = categoryLabel.heightAnchor.constraint(equalToConstant: 40)
        heightConstraint.priority = .defaultLow
        let widthConstraint = categoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 70)
        widthConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            heightConstraint,
            widthConstraint
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAppearance(isSelected: Bool) {
        backgroundColor = isSelected ? .black : .systemGray6
        categoryLabel.textColor = isSelected ? .white : .black
        layer.borderWidth = isSelected ? 0 : 1
        layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func configure(category: String, isSelected: Bool) {
        categoryLabel.text = category
        
        configureAppearance(isSelected: isSelected)
        if isSelected {
            backgroundColor = .black
            categoryLabel.textColor = .white
        } else {
            backgroundColor = UIColor.systemGray6
            categoryLabel.textColor = .black
        }
        
        // Fade-in animation for collection cell with transform effect
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
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

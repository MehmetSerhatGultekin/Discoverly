//
//  ViewController.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//

import UIKit

struct MovieResponse: Decodable {
    let results: [Content]
}

class HomeViewController: UIViewController {
    
    var selectedCategory: String = "All"
    
    let categories: [String] = [
        "All",
        "Drama",
        "Comedy",
        "Action",
        "Thriller",
        "Sci-Fi",
        "Horror"
    ]
    
    var allContents: [Content] = []
    var filteredContents: [Content] = []
   
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let homeView = view as? HomeView else { return }
        homeView.categoryCollectionView.delegate = self
        homeView.categoryCollectionView.dataSource = self
        homeView.categoryCollectionView.register(Categorycell.self, forCellWithReuseIdentifier: "CategoryCell") // kategori cell entegrasyonu
        
        homeView.contentTableView.register(ContentCell.self, forCellReuseIdentifier: "ContentCell")
        homeView.contentTableView.delegate = self
        homeView.contentTableView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        let apiKey = "a207ceabe80f15aacffcc7510a50dcdc"

        let group = DispatchGroup() // Birden fazla sayfayı çekmek için bu yapı kullanılıyor.DispatchGroup, tüm işlemler bitene kadar beklememizi sağlar.
        var combinedResults: [Content] = []

        for page in 1...15 {
            group.enter()
            let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=\(page)"
            guard let url = URL(string: urlString) else {
                group.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() }

                if let error = error {
                    print("Hata: \(error.localizedDescription)")
                    return
                }

                guard let data = data else { return }

                if let rawString = String(data: data, encoding: .utf8) {
                    print("Ham Veri - Sayfa \(page):\n\(rawString)")
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    combinedResults.append(contentsOf: decodedResponse.results)
                } catch {
                    print("Decoding error (sayfa \(page)): \(error)")
                }
            }.resume()
        }

        group.notify(queue: .main) {
            self.allContents = combinedResults
            self.filteredContents = combinedResults

            if let homeView = self.view as? HomeView {
                homeView.contentTableView.reloadData()
            }

            print("Tüm sayfalardan gelen toplam içerik: \(combinedResults.count)")
            combinedResults.forEach {
                print("Title: \($0.title), Genre IDs: \($0.genreIDs), Category: \($0.category)")
            }
        }
    }
}

extension HomeViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! Categorycell
        let category = categories[indexPath.item]
        cell.categoryLabel.text = category
        
        // Vurgulama burada yapılır
        let isSelected = (category == selectedCategory)
        cell.configureAppearance(isSelected: isSelected)
        if isSelected {
            cell.backgroundColor = .black
            cell.categoryLabel.textColor = .white
        } else {
            cell.backgroundColor = UIColor.systemGray6
            cell.categoryLabel.textColor = .black
        }
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        // Fade-in animation for collection cell with transform effect
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
            cell.transform = .identity
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 40) // itemlerin size'laarı ayarlandı
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        selectedCategory = category
        
        if category == "All" {
            filteredContents = allContents
        } else {
            filteredContents = allContents.filter {
                $0.category.lowercased() == category.lowercased()
            }
        }
        
        if let homeView = view as? HomeView {
            homeView.contentTableView.reloadData()
        }
        
        collectionView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as? ContentCell else {
            return UITableViewCell()
        }
        
        let content = filteredContents[indexPath.row]
        cell.titleLabel.text = content.title
        cell.categoryLabel.text = content.category
        // Set background color and fade-in animation
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.titleLabel.textColor = .black
        cell.categoryLabel.textColor = .darkGray
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
            cell.transform = .identity
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContent = filteredContents[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.content = selectedContent
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true) // tıklanılan satırın gri kalmasını önler
    }
}


// MARK: GENEL NOTLAR

/*
 1.COLLLECTİONVİEW BAZI PROTOKLLER
 •    delegate: Hücreye tıklanma, scroll edilme gibi kullanıcı etkileşimlerini yönetmek için kullanılır.
 •    dataSource: Kaç hücre olacağı ve her hücrede ne gösterileceğini veriyle kontrol etmek için kullanılır.
 •    delegateFlowLayout: Hücrelerin boyutunu ve aralarındaki boşluğu dinamik olarak ayarlamak için kullanılır (özellikle CollectionView’da).
 
 2.TABLEVİEW BAZI PROTOKOLLER
 dataSource — veri sorumlusu
 delegate — kullanıcı etkileşimleri
 */

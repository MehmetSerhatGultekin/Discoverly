//
//  DetailViewController.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//

import UIKit

import UIKit

class DetailViewController: UIViewController {

    var content: Content?

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
    }
}




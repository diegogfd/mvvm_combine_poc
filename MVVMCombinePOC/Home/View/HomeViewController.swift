//
//  HomeViewController.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol
    private let coordinator: HomeCoordinatorProtocol
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is an example home"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    init(viewModel: HomeViewModelProtocol, coordinator: HomeCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(self.titleLabel)
        self.view.backgroundColor = UIColor.white
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.titleLabel.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 16)
        ])
    }
    
}

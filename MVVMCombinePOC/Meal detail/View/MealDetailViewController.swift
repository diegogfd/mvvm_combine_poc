//
//  MealDetailViewController.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 15/10/2021.
//

import Foundation
import UIKit
import Kingfisher
import Combine

class MealDetailViewController: UIViewController {
    
    private let viewModel: MealDetailViewModelProtocol
    private let viewModelInput = MealDetailViewModelInput()
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var instructionsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    init(viewModel: MealDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bind()
        self.viewModelInput.viewLoadedPublisher.send()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.mealImageView)
        NSLayoutConstraint.activate([
            self.mealImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.mealImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mealImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mealImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        self.view.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.mealImageView.bottomAnchor, constant: 16),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
        self.view.addSubview(self.instructionsTextView)
        NSLayoutConstraint.activate([
            self.instructionsTextView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
            self.instructionsTextView.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.instructionsTextView.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            self.instructionsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func fillWithData(mealDetailViewData: MealDetailViewData) {
        self.mealImageView.kf.setImage(with: mealDetailViewData.thumbnailURL)
        self.nameLabel.text = mealDetailViewData.title
        self.instructionsTextView.text = mealDetailViewData.instructions
    }
    
    private func bind() {
        let output = self.viewModel.bind(input: self.viewModelInput)
        output.mealDetailPublisher.sink(receiveValue: {self.fillWithData(mealDetailViewData: $0)})
            .store(in: &self.subscriptions)
    }
    
}

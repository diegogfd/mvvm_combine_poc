//
//  MealListItemCell.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation
import UIKit

class MealListItemCell: UITableViewCell {
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(thumbnailImageView)
        let imageHeightConstraint = thumbnailImageView.heightAnchor.constraint(equalToConstant: 40)
        imageHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 40),
            imageHeightConstraint,
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        self.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([            nameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setup(viewModel: MealListCellData) {
        nameLabel.text = viewModel.title
        thumbnailImageView.kf.setImage(with: viewModel.thumbnailURL, placeholder: UIImage(systemName: "heart.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

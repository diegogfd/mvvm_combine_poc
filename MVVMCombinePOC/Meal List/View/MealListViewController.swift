//
//  ViewController.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 29/09/2021.
//

import UIKit
import Combine
import Kingfisher

class MealListViewController: UIViewController {
    
    private let cellIdentifier = "cell"
    private var subscriptions = Set<AnyCancellable>()

    let viewModel: MealListViewModelProtocol
    
    private let viewModelInput = MealListViewModelInput()
    private var mealViewModels: [MealListCellData] = []
    
    var coordinator: MealListCoordinatorProtocol

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MealListItemCell.self, forCellReuseIdentifier: self.cellIdentifier)
        return tableView
    }()
    
    init(viewModel: MealListViewModelProtocol, coordinator: MealListCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.setupView()
        self.viewModelInput.viewLoadedPublisher.send()
    }
    
    func bind() {
        let output = self.viewModel.bind(input: self.viewModelInput)
        output.mealsPublisher.sink { error in
            self.showError()
        } receiveValue: { meals in
            self.mealViewModels = meals
            self.tableView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func showError() {
        let alertController = UIAlertController(title: "Error", message: "There was an error", preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: .default) { _ in
            self.viewModelInput.retryPublisher.send()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MealListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? MealListItemCell else {
            return UITableViewCell()
        }
        let mealViewModel = self.mealViewModels[indexPath.row]
        cell.setup(viewModel: mealViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModelInput.tapRowPublisher.send(indexPath.row)
    }
}


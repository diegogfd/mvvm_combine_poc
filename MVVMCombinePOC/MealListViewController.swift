//
//  ViewController.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 29/09/2021.
//

import UIKit
import Combine

protocol ViewModel {
    
}

protocol Bindable {
    func bind()
}

class MealListViewController: UIViewController {
    
    private let cellIdentifier = "cell"
    private let viewModel: MealListViewModel
    private var subscriptions = Set<AnyCancellable>()
        
    private let tapRowPublisher = PassthroughSubject<Int, Never>()
    private let viewLoadedPublisher = PassthroughSubject<Void, Never>()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        return tableView
    }()
    
    init(viewModel: MealListViewModel = MealListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.setupView()
        self.viewLoadedPublisher.send()
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
}

extension MealListViewController: Bindable {
    
    func bind() {
        self.viewModel.bind(input: MealListViewModelInput(viewLoadedPublisher: self.viewLoadedPublisher.eraseToAnyPublisher(), tapRowPublisher: self.tapRowPublisher.eraseToAnyPublisher()))

        self.viewModel.mealsPublisher.sink { meals in
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }
}

extension MealListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) ?? UITableViewCell()
        let meal = self.viewModel.meals[indexPath.row]
        cell.textLabel?.text = meal.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tapRowPublisher.send(indexPath.row)
    }
}


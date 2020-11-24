//
//  BreweriesViewController.swift
//  Breweries
//
//  Created by vit on 24.11.2020.
//

import UIKit

class BreweriesViewController: UIViewController {
    
    private let viewModel = BreweriesViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BreweryCell.self, forCellReuseIdentifier: BreweryCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.backgroundColor = .secondary
        tableView.separatorStyle = .none
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getBreweries()
    }
    
    private func setup() {
        setupLayout()
        setupNavigationBar()
        setupObservers()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Breweries"
        navigationController?.addCustomBottomLine(color: .secondary, height: 3.0)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .complete, object: viewModel)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .failure, object: viewModel)
    }
    
    @objc private func handleNotification(_ notification: Notification) {
        switch notification.name {
        case .complete:
            reloadData()
        case .failure:
            alertHandler(title: "Error response!", message: "Try again")
        default:
            break
        }
    }
    
    private func reloadData() {
        let indexPaths = viewModel.breweries.indices.map { IndexPath(item: $0, section: 0) }
        DispatchQueue.main.async {
            self.tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    private func getBreweries() {
        viewModel.getBreweries()
    }
    
    private func alertHandler(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let refresh = UIAlertAction(title: "Refresh", style: .default, handler: { _ in self.getBreweries() })
        alert.addAction(refresh)
        present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - table view data source

extension BreweriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreweryCell.reuseID, for: indexPath) as! BreweryCell
        let brewery = viewModel.breweries[indexPath.row]
        cell.configureCell(with: brewery)
        return cell
    }
}

// MARK: - navigation controller

extension UINavigationController {
    
    func addCustomBottomLine(color: UIColor, height: Double) {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = color
        
        navigationBar.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
        ])
    }
}

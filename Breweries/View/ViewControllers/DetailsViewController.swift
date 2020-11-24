//
//  DetailsViewController.swift
//  Breweries
//
//  Created by vit on 24.11.2020.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {
    
    var brewery: Brewery!
    
    private lazy var containerView: UIView = {
        let outputView = UIView()
        outputView.translatesAutoresizingMaskIntoConstraints = false
        return outputView
    }()
    
    private lazy var buttonView: UIView = {
        let outputView = UIView()
        outputView.translatesAutoresizingMaskIntoConstraints = false
        return outputView
    }()
    
    private lazy var nameLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = .boldSystemFont(ofSize: 21)
        outputLabel.numberOfLines = 0
        outputLabel.textColor = .main
        outputLabel.textAlignment = .center
        return outputLabel
    }()
    
    private lazy var infoVStack: UIStackView = {
        let outputStack = UIStackView()
        outputStack.translatesAutoresizingMaskIntoConstraints = false
        outputStack.axis = .vertical
        outputStack.distribution = .equalSpacing
        outputStack.spacing = 5
        return outputStack
    }()
    
    private lazy var phoneLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = .systemFont(ofSize: 15)
        outputLabel.textColor = .coffee
        return outputLabel
    }()
    
    private lazy var countryLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = .systemFont(ofSize: 17)
        outputLabel.textColor = .coffee
        return outputLabel
    }()
    
    private lazy var cityLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = .systemFont(ofSize: 17)
        outputLabel.textColor = .coffee
        return outputLabel
    }()
    
    private lazy var stateLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = .systemFont(ofSize: 17)
        outputLabel.textColor = .coffee
        return outputLabel
    }()
    
    private lazy var streetLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = .systemFont(ofSize: 17)
        outputLabel.textColor = .coffee
        return outputLabel
    }()
    
    private lazy var goToWebsiteButton: UIButton = {
        let outputButton = UIButton()
        outputButton.addTarget(self, action: #selector(goToBrewerySite), for: .touchUpInside)
        outputButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        outputButton.translatesAutoresizingMaskIntoConstraints = false
        outputButton.setTitle("Visit the site", for: .normal)
        outputButton.setTitleColor(.gray, for: .disabled)
        outputButton.layer.cornerRadius = 8
        outputButton.layer.masksToBounds = true
        outputButton.backgroundColor = .main
        return outputButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupLayout()
        fillInformation()
    }
    
    private func setupLayout() {
        
        view.backgroundColor = .beige
        view.addSubview(containerView)
        buttonView.addSubview(goToWebsiteButton)
        
        [nameLabel,
        phoneLabel,
        infoVStack,
        buttonView].forEach { containerView.addSubview($0) }
        
        [countryLabel,
        cityLabel,
        stateLabel,
        streetLabel].forEach { infoVStack.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            phoneLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            infoVStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            infoVStack.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 40),
            
            buttonView.topAnchor.constraint(equalTo: infoVStack.bottomAnchor),
            buttonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            goToWebsiteButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            goToWebsiteButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            
        ])
        
        if let url = brewery.websiteURL, url.isEmpty {
            goToWebsiteButton.isEnabled = false
            goToWebsiteButton.alpha = 0.8
        }
    }
    
    private func fillInformation() {
        nameLabel.text = brewery.name
        phoneLabel.text = "phone:  +\(brewery.phone ?? "-")"
        countryLabel.text = "* country:  \(brewery.country ?? "-")"
        cityLabel.text = "* city: \(brewery.city ?? "-")"
        stateLabel.text = "* state:  \(brewery.state ?? "-")"
        streetLabel.text = "* street:  \(brewery.street ?? "-")"
    }
    
    @objc private func goToBrewerySite() {
        if let websiteURLRaw = brewery.websiteURL, let websiteURL = URL(string: websiteURLRaw) {
            let svc = SFSafariViewController(url: websiteURL)
            svc.overrideUserInterfaceStyle = .dark
            present(svc, animated: true)
        }
    }
}

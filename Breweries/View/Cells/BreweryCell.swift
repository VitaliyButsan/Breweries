//
//  BreweryCell.swift
//  Breweries
//
//  Created by vit on 24.11.2020.
//

import UIKit

class BreweryCell: UITableViewCell {
    
    static let reuseID = "BreweryCellIdentifier"
    
    private lazy var mainView: UIView = {
        let outputView = UIView()
        outputView.translatesAutoresizingMaskIntoConstraints = false
        outputView.backgroundColor = .main
        outputView.layer.cornerRadius = 8
        outputView.layer.masksToBounds = true
        return outputView
    }()
    
    private lazy var nameLabel: UILabel = {
        let outputLabel = UILabel()
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.numberOfLines = 0
        outputLabel.font = .systemFont(ofSize: 20)
        outputLabel.textColor = .white
        return outputLabel
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let outputView = UIImageView()
        outputView.translatesAutoresizingMaskIntoConstraints = false
        outputView.image = UIImage(systemName: "chevron.right")
        outputView.tintColor = .white
        return outputView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .beige
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(mainView)
        mainView.addSubview(nameLabel)
        mainView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            
            chevronImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            chevronImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            chevronImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func configureCell(with brewery: Brewery) {
        nameLabel.text = brewery.name
    }
}

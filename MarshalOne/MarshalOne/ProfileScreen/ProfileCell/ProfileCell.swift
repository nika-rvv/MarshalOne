//
//  ProfileCell.swift
//  MarshalOne
//
//  Created by Veronika on 04.03.2023.
//

import UIKit

final class ProfileCell: UITableViewCell {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainBlue()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainTextColor()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = R.color.cellColor()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileCell {
    private func setupSubviews(){
        self.addSubview(mainLabel)
        self.addSubview(infoLabel)
    }
    
    private func setupConstraints(){
        mainLabel.top(4, isIncludeSafeArea: false)
        mainLabel.leading(12)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 2),
            infoLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
        ])
    }
    
    func configureCellWith(with main: String, and info: String) {
        mainLabel.text = main
        infoLabel.text = info
    }
}

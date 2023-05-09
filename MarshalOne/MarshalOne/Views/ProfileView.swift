//
//  ProfileView.swift
//  MarshalOne
//
//  Created by Veronika on 04.03.2023.
//

import UIKit

final class ProfileView: UIView {
    private let profileStackView: UIStackView = {
        let profileSV = UIStackView()
        profileSV.translatesAutoresizingMaskIntoConstraints = false
        profileSV.axis = .vertical
        profileSV.spacing = 8
        return profileSV
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.profileImage()
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        name.textColor = R.color.mainTextColor()
        name.textAlignment = .center
        return name
    }()
    
    private let cityLabel: UILabel = {
        let city = UILabel()
        city.translatesAutoresizingMaskIntoConstraints = false
        city.font = UIFont.systemFont(ofSize: 16, weight: .light)
        city.textColor = R.color.mainTextColor()
        city.textAlignment = .center
        return city
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension ProfileView {
    private func addViews() {
        self.addSubview(profileStackView)
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(nameLabel)
        profileStackView.addArrangedSubview(cityLabel)
    }
    
    private func setupConstraints() {
        profileStackView.top(isIncludeSafeArea: true)
        profileStackView.centerX()
        profileStackView.width(100)
        
        profileImageView.height(100)
        profileImageView.width(100)
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: profileStackView.centerXAnchor)
        ])
    }
    
    func configureView(with name: String, and city: String) {
        nameLabel.text = name
        cityLabel.text = city
    }
}

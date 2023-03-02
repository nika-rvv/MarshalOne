//
//  CustomNavigationBar.swift
//  MarshalOne
//
//  Created by Veronika on 02.03.2023.
//

import UIKit

protocol NavigationBarDelegate: AnyObject {
    func backButtonAction()
}

final class NavigationBarView: UIView {
    weak var delegate: NavigationBarDelegate?
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = R.color.mainBlue()
        label.textAlignment = .center
        return label
    }()

    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.backButton(), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupConstraints()
        setupUI()
    }
}

extension NavigationBarView {
    func setupConstraints() {
        self.addSubview(mainLabel)
        self.addSubview(backButton)
        
        mainLabel.top(50, isIncludeSafeArea: false)
        mainLabel.centerX()
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor)
        ])
        backButton.leading(17)
        
    }
    func setupUI() {
        backButton.isUserInteractionEnabled = true
        backButton.addTarget(self, action:#selector(backButtonTapped), for: .touchUpInside)
    }
    @objc
    func backButtonTapped(){
        delegate?.backButtonAction()
    }
}

extension NavigationBarView {
    func setConfigForEventsScreen() {
        backButton.isHidden = true
        mainLabel.text = R.string.localizable.events()
    }
    
    func setupConfigForRegisterScreen() {
        backButton.isHidden = false
        mainLabel.isHidden = true
    }
}

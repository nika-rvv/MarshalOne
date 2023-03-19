//
//  EventContentView.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//

import UIKit

final class EventContentView: UIView {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainBlue()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let placeDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainOrange()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.tfText()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainTextColor()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.cellBackgroundColor()
        setupView()
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension EventContentView {
    private func setupView(){
        self.addSubview(mainLabel)
        
        self.addSubview(placeDateStackView)
        placeDateStackView.addArrangedSubview(placeLabel)
        placeDateStackView.addArrangedSubview(dateLabel)
        
        self.addSubview(additionalInfoLabel)
    }
    
    private func setupConstraits(){
        mainLabel.top(24, isIncludeSafeArea: true)
        mainLabel.leading(20)
        mainLabel.trailing(-20)
        
        NSLayoutConstraint.activate([
            placeDateStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8)
        ])
        placeDateStackView.leading(20)
        placeDateStackView.trailing(-20)
        placeDateStackView.height(20)
        
        NSLayoutConstraint.activate([
            additionalInfoLabel.topAnchor.constraint(equalTo: placeDateStackView.bottomAnchor, constant: 12)
        ])
        additionalInfoLabel.leading(20)
        additionalInfoLabel.trailing(-20)
    }
    
    func configureViewWith(mainText: String, placeText: String, dateText: String, additionalText: String) {
        mainLabel.text = mainText
        placeLabel.text = placeText
        dateLabel.text = dateText
        additionalInfoLabel.text = additionalText
    }
}


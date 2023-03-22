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
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
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
    
    private let spacerView = UIView()
    
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
        self.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(mainLabel)
        infoStackView.addArrangedSubview(placeDateStackView)
        
        placeDateStackView.addArrangedSubview(placeLabel)
        placeDateStackView.addArrangedSubview(dateLabel)
        
        infoStackView.addArrangedSubview(additionalInfoLabel)
        infoStackView.addArrangedSubview(spacerView)
    }
    
    private func setupConstraits(){
        infoStackView.top(isIncludeSafeArea: false)
        infoStackView.leading(20)
        infoStackView.trailing(-20)
        infoStackView.bottom(isIncludeSafeArea: false)
        
        mainLabel.leading()
        mainLabel.trailing()
        
        placeDateStackView.leading()
        placeDateStackView.trailing()
        
        additionalInfoLabel.leading()
        additionalInfoLabel.trailing()
        
        infoStackView.setCustomSpacing(12, after: placeDateStackView)
    }
    
    func configureViewWith(mainText: String, placeText: String, dateText: String, additionalText: String) {
        mainLabel.text = mainText
        placeLabel.text = placeText
        dateLabel.text = dateText
        additionalInfoLabel.text = additionalText
    }
}


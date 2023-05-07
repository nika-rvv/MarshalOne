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
    
    private let eventMapView: EventMapView = {
        let map = EventMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 8
        map.clipsToBounds = true
        return map
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

private extension EventContentView {
     func setupView(){
        self.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(mainLabel)
        
        infoStackView.addArrangedSubview(placeLabel)
        infoStackView.addArrangedSubview(dateLabel)
        
        infoStackView.addArrangedSubview(additionalInfoLabel)
        
        infoStackView.addArrangedSubview(eventMapView)
    }
    
    func setupConstraits(){
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12)
        ])
        infoStackView.leading(20)
        infoStackView.trailing(-20)
        infoStackView.bottom(isIncludeSafeArea: false)
        
        mainLabel.leading()
        mainLabel.trailing()
        
        placeLabel.leading()
        placeLabel.trailing()
        
        dateLabel.leading()
        dateLabel.trailing()
        
        additionalInfoLabel.leading()
        additionalInfoLabel.trailing()
        
        eventMapView.leading()
        eventMapView.trailing()
        eventMapView.height(180)
        
    }
}

extension EventContentView {
    func configureViewWith(mainText: String,
                           placeName: String,
                           dateText: String,
                           additionalText: String,
                           longitude: Double,
                           latitude: Double) {
        mainLabel.text = mainText
        placeLabel.text = placeName
        dateLabel.text = dateText
        additionalInfoLabel.text = additionalText
        eventMapView.cofigureMap(latitude: latitude, longitude: longitude, name: placeName)
    }
}


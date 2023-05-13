//
//  EventContentView.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//

import UIKit

final class EventContentView: UIView {
    typealias ParticipateAction = () -> ()
    
    private var setParticipationAction: ParticipateAction?
    private var unsetParticipationAction: ParticipateAction?
    
    private var isUserMember: Bool = false
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainBlue()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
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
    
    private let participateButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var realHeight: CGFloat = 0
    
    var height: CGFloat {
        return realHeight
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.cellColor()
        setupView()
        setupConstraits()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        realHeight = mainLabel.frame.size.height + placeLabel.frame.size.height + dateLabel.frame.size.height + additionalInfoLabel.frame.size.height + eventMapView.frame.size.height + participateButton.frame.size.height + 24 + 48
    }
}

private extension EventContentView {
    func setupView(){
        self.addSubview(mainLabel)
        self.addSubview(placeLabel)
        self.addSubview(dateLabel)
        self.addSubview(additionalInfoLabel)
        self.addSubview(eventMapView)
        self.addSubview(participateButton)
    }
    
    func setupConstraits(){
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12)
        ])
        mainLabel.leading(20)
        mainLabel.trailing(-20)
        
        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8)
        ])
        placeLabel.leading(20)
        placeLabel.trailing(-20)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 8)
        ])
        dateLabel.leading(20)
        dateLabel.trailing(-20)
        
        NSLayoutConstraint.activate([
            additionalInfoLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12)
        ])
        additionalInfoLabel.leading(20)
        additionalInfoLabel.trailing(-20)
        
        NSLayoutConstraint.activate([
            eventMapView.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor, constant: 12)
        ])
        eventMapView.leading(20)
        eventMapView.trailing(-20)
        eventMapView.height(180)
        
        NSLayoutConstraint.activate([
            participateButton.topAnchor.constraint(equalTo: eventMapView.bottomAnchor, constant: 12)
        ])
        participateButton.leading(20)
        participateButton.trailing(-20)
        participateButton.height(42)
    }
    
    func setupActions() {
        participateButton.addTarget(self, action: #selector(participateButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func participateButtonTapped() {
        if !isUserMember {
            setParticipationAction?()
            isUserMember = !isUserMember
        } else {
            unsetParticipationAction?()
            isUserMember = !isUserMember
        }
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
    
    func configureButton(isMember: Bool) {
        if isMember {
            participateButton.tintColor = R.color.mainOrange()
            participateButton.setupTitle(with: "Вы записаны")
            isUserMember = isMember
        } else {
            participateButton.setupTitle(with: R.string.localizable.participate())
            participateButton.tintColor = R.color.mainBlue()
            isUserMember = isMember
        }
    }
    
    func setParticipateAction(_ action: @escaping ParticipateAction) {
        self.setParticipationAction = action
    }
    
    func unsetParticipateAction(_ action: @escaping ParticipateAction) {
        self.unsetParticipationAction = action
    }
}


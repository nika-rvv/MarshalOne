//
//  EventsInfoStackView.swift
//  MarshalOne
//
//  Created by Veronika on 04.03.2023.
//

import UIKit

final class EventsInfoStackView: UIStackView {
    private let infoImageView: UIImageView = {
        let info = UIImageView()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.contentMode = .scaleAspectFill
        info.layer.masksToBounds = true
        return info
    }()
    
    private let infoLabel: UILabel = {
        let info = UILabel()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.textColor = R.color.mainBlue()
        info.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return info
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventsInfoStackView {
    private func setupUI() {
        self.addArrangedSubview(infoImageView)
        infoImageView.top(isIncludeSafeArea: false)
        infoImageView.height(24)
        infoImageView.width(24)
        infoImageView.leading()
        infoImageView.bottom(isIncludeSafeArea: false)
        
        self.addArrangedSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: infoImageView.centerYAnchor)
        ])
        
        self.axis = .horizontal
        self.setCustomSpacing(4, after: infoImageView)
    }
    
    func configureForLikes(isLiked: Bool, numberOfLikes: Int) {
        infoImageView.image = isLiked ? R.image.likedImage() : R.image.notLikedImage()
        infoLabel.text = "\(numberOfLikes)"
    }
    
    func configureForParticipants(numberOfParticipants: Int) {
        infoImageView.image = R.image.participantsImage()
        infoLabel.text = "\(numberOfParticipants)"
    }
    
    func configureForWatchers(numberOfWatchers: Int) {
        infoImageView.image = R.image.viewsImage()
        infoLabel.text = "\(numberOfWatchers)"
    }
}

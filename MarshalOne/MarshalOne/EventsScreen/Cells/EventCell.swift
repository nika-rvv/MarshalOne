//
//  EventCell.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//

import UIKit

final class EventCell: UITableViewCell {
    
    private let cellView: UIView = {
        let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = R.color.cellColor()
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainBlue()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainOrange()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let placeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.image.racePlace()
        return image
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = R.color.mainBlue()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let placeStackView: UIStackView = {
        let placeSV = UIStackView()
        placeSV.translatesAutoresizingMaskIntoConstraints = false
        placeSV.axis = .horizontal
        placeSV.spacing = 4
        return placeSV
    }()
    
    private let raceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .loginImage
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = R.color.mainBlue()?.cgColor
        return image
    }()
    
    private let likeStackView: EventsInfoStackView = {
        let like = EventsInfoStackView()
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    private let viewsStackView: EventsInfoStackView = {
        let views = EventsInfoStackView()
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    private let participantsStackView: EventsInfoStackView = {
        let participants = EventsInfoStackView()
        participants.translatesAutoresizingMaskIntoConstraints = false
        return participants
    }()
    
    private let infoStackView: UIStackView = {
        let info = UIStackView()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.axis = .horizontal
        info.distribution = .fillProportionally
//        info.spacing = 8
        return info
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = R.color.cellBackgroundColor()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EventCell {
    private func setupSubviews() {
        self.contentView.addSubview(cellView)
        
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
        
        self.addSubview(placeStackView)
        placeStackView.addArrangedSubview(placeImage)
        placeStackView.addArrangedSubview(placeLabel)
        
        self.addSubview(raceImage)
        
        self.addSubview(infoStackView)
        infoStackView.addArrangedSubview(likeStackView)
        infoStackView.addArrangedSubview(viewsStackView)
        infoStackView.addArrangedSubview(participantsStackView)
    }
    
    private func setupConstraints() {
        cellView.top(isIncludeSafeArea: false)
        cellView.leading()
        cellView.trailing()
        cellView.height(340)
        
        titleLabel.top(16, isIncludeSafeArea: false)
        titleLabel.leading(24)
        titleLabel.trailing(-24)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
        dateLabel.leading(24)
        
        NSLayoutConstraint.activate([
            placeStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8)
        ])
        placeStackView.leading(24)
        
        NSLayoutConstraint.activate([
            raceImage.topAnchor.constraint(equalTo: placeStackView.bottomAnchor, constant: 8)
        ])
        raceImage.leading(12)
        raceImage.trailing(-12)
        raceImage.height(180)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: raceImage.bottomAnchor, constant: 8),
        ])
        infoStackView.leading(18)
        infoStackView.height(24)
        infoStackView.trailing(-18)
    }
    
    func configureCellWith(title: String,
                           date: String,
                           place: String,
                           likes: String,
                           views: String,
                           participants: String) {
        titleLabel.text = title
        dateLabel.text = date
        placeLabel.text = place
        likeStackView.configureStackView(with: R.image.notLikedImage(), and: likes)
        viewsStackView.configureStackView(with: R.image.viewsImage(), and: views)
        participantsStackView.configureStackView(with: R.image.participantsImage(), and: participants)
    }
}

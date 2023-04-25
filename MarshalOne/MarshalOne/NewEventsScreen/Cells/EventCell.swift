//
//  EventCell.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//

import UIKit

final class EventCell: UITableViewCell {
    typealias LikeAction = () -> Void
    typealias DislikeAction = () -> Void
    
    private var likeAction: LikeAction?
    private var dislikeAction: DislikeAction?
            
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
        return info
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = R.color.cellBackgroundColor()
        setupSubviews()
        setupConstraints()
        setupLikeStackView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        dateLabel.text = ""
        placeLabel.text = ""
        likeStackView.configureForLikes(isLiked: false, numberOfLikes: 0)
        viewsStackView.configureForWatchers(numberOfWatchers: 0)
        viewsStackView.configureForParticipants(numberOfParticipants: 0)
    }
    
}

private extension EventCell {
    func setupSubviews() {
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
    
    func setupConstraints() {
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
    
}

// actions
private extension EventCell {
    func setupLikeStackView(){
        likeStackView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(setLikeState)))
    }
    
    @objc
    func setLikeState() {
//        if !isEventLiked {
//            likeStackView.changeStackView(with: R.image.likedImage())
//            isEventLiked = !isEventLiked
//            likeAction?()
//        } else {
//            likeStackView.changeStackView(with: R.image.notLikedImage())
//            isEventLiked = !isEventLiked
//            dislikeAction?()
//        }
    }
    
}

extension EventCell {
    func setLikeAction(_ action: @escaping LikeAction) {
        self.likeAction = action
    }
    
    func setDislikeAction(_ action: @escaping DislikeAction) {
        self.dislikeAction = action
    }
    
    func configure(title: String,
                   dateSubtitle: String,
                   placeName: String,
                   imageId: String,
                   numberOfLikes: Int,
                   numberOfParticipants: Int,
                   numberOfWatchers: Int,
                   isLiked: Bool) {
        titleLabel.text = title
        dateLabel.text = dateSubtitle
        placeLabel.text = placeName
        likeStackView.configureForLikes(isLiked: isLiked, numberOfLikes: numberOfLikes)
        viewsStackView.configureForWatchers(numberOfWatchers: numberOfWatchers)
        participantsStackView.configureForParticipants(numberOfParticipants: numberOfParticipants)
    }
}

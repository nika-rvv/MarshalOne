//
//  ProfileActionView.swift
//  MarshalOne
//
//  Created by Veronika on 04.03.2023.
//

import UIKit

final class ProfileActionView: UIView {
    private let actionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let actionImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.cellColor()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileActionView {
    private func setupViews() {
        self.addSubview(actionLabel)
        self.addSubview(actionImageView)
    }
    
    private func setupConstraints() {
        actionLabel.top(12, isIncludeSafeArea: false)
        actionLabel.leading(12)
        actionLabel.trailing(-84)
        
        NSLayoutConstraint.activate([
            actionImageView.topAnchor.constraint(equalTo: actionLabel.topAnchor),
            actionImageView.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36)
        ])
        actionImageView.trailing(-12)
        actionImageView.width(24)
        actionImageView.height(24)
    }
    
    func configureViewWith(text: String, textColor: UIColor?, image: UIImage?) {
        actionLabel.text = text
        actionLabel.textColor = textColor
        actionImageView.image = image
    }
}

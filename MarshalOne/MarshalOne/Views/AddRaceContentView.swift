//
//  AddRaceContentView.swift
//  MarshalOne
//
//  Created by Veronika on 18.03.2023.
//

import UIKit

final class AddRaceContentView: UIView {
    
    private let mainLabel: UILabel = {
        let main = UILabel()
        main.translatesAutoresizingMaskIntoConstraints = false
        main.textColor = R.color.mainBlue()
        main.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return main
    }()
    
    private let eventNameTextField: CustomTF = {
        let event = CustomTF()
        event.translatesAutoresizingMaskIntoConstraints = false
        event.setupPlaceholder(with: "Название гонки")
        return event
    }()
    
    private let dateFromToStackView: UIStackView = {
        let dates = UIStackView()
        dates.translatesAutoresizingMaskIntoConstraints = false
        dates.axis = .horizontal
        dates.distribution = .fillProportionally
        return dates
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

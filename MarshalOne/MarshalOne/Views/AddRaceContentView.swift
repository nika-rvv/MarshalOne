//
//  AddRaceContentView.swift
//  MarshalOne
//
//  Created by Veronika on 18.03.2023.
//

import UIKit

final class AddRaceContentView: UIView {

    typealias CloseClosure = () -> Void
    typealias AddClosure = ([String?]) -> Void
    
    private var closeAction: CloseClosure?
    
    private var addAction: AddClosure?
    
    private let mainLabel: UILabel = {
        let main = UILabel()
        main.translatesAutoresizingMaskIntoConstraints = false
        main.textColor = R.color.mainBlue()
        main.text = R.string.localizable.addRace()
        main.textAlignment = .center
        main.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return main
    }()
    
    private let closeButton: UIButton = {
        let close = UIButton()
        close.setImage(R.image.closeButton(), for: .normal)
        close.translatesAutoresizingMaskIntoConstraints = false
        close.tintColor = R.color.mainBlue()
        close.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return close
    }()
    
    private let eventNameTextField: CustomTF = {
        let event = CustomTF()
        event.translatesAutoresizingMaskIntoConstraints = false
        event.setupPlaceholder(with: R.string.localizable.eventName())
        return event
    }()
    
    private let dateFromToStackView: UIStackView = {
        let dates = UIStackView()
        dates.translatesAutoresizingMaskIntoConstraints = false
        dates.axis = .horizontal
        dates.distribution = .fillProportionally
        dates.spacing = 12
        return dates
    }()
    
    private let dateFromTextField: CustomTF = {
        let dateFrom = CustomTF()
        dateFrom.translatesAutoresizingMaskIntoConstraints = false
        dateFrom.setupPlaceholder(with: R.string.localizable.dateFrom())
        return dateFrom
    }()
    
    private let dateToTextField: CustomTF = {
        let dateTo = CustomTF()
        dateTo.translatesAutoresizingMaskIntoConstraints = false
        dateTo.setupPlaceholder(with: R.string.localizable.dateTo())
        return dateTo
    }()
    
    private let placeTextField: CustomTF = {
        let place = CustomTF()
        place.translatesAutoresizingMaskIntoConstraints = false
        place.setupPlaceholder(with: R.string.localizable.placeOfEvent())
        return place
    }()
    
    private let descriptonTextView: UITextView = {
        let description = UITextView()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = R.string.localizable.eventDescription()
        description.textColor = R.color.tfText()
        description.backgroundColor = .tfColor
        description.font = .systemFont(ofSize: 13)
        description.layer.borderColor = UIColor.tfText?.cgColor
        description.layer.borderWidth = 1
        description.layer.cornerRadius = 4
        description.layer.cornerRadius = 4
        description.clipsToBounds = true
        return description
    }()
    
    let raceImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.image.addRacePicker()
        image.layer.cornerRadius = 4
        image.layer.borderWidth = 1
        image.layer.borderColor = R.color.mainBlue()?.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    private let addButton: CustomButton = {
        let add = CustomButton()
        add.translatesAutoresizingMaskIntoConstraints = false
        add.setupTitle(with: R.string.localizable.addRace())
        add.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return add
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        descriptonTextView.delegate = self
        addVeiws()
        setupConstraints()
        setupDatePicker()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension AddRaceContentView {
    
    func addVeiws() {
        self.addSubview(mainLabel)
        self.addSubview(closeButton)
        self.addSubview(eventNameTextField)
        self.addSubview(dateFromToStackView)
        dateFromToStackView.addArrangedSubview(dateFromTextField)
        dateFromToStackView.addArrangedSubview(dateToTextField)
        self.addSubview(placeTextField)
        self.addSubview(descriptonTextView)
        self.addSubview(addButton)
        self.addSubview(raceImageView)
    }
    
    func setupConstraints(){
        mainLabel.top(24, isIncludeSafeArea: true)
        mainLabel.leading(24)
        mainLabel.trailing(-24)
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor)
        ])
        closeButton.trailing(-24)
        closeButton.width(48)
        closeButton.height(48)
        
        NSLayoutConstraint.activate([
            eventNameTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24)
        ])
        eventNameTextField.leading(24)
        eventNameTextField.trailing(-24)
        eventNameTextField.height(42)
        
        NSLayoutConstraint.activate([
            dateFromToStackView.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor, constant: 12)
        ])
        dateFromToStackView.leading(24)
        dateFromToStackView.trailing(-24)
        dateFromToStackView.height(42)
        
        NSLayoutConstraint.activate([
            placeTextField.topAnchor.constraint(equalTo: dateFromToStackView.bottomAnchor, constant: 12)
        ])
        placeTextField.leading(24)
        placeTextField.trailing(-24)
        placeTextField.height(42)
        
        NSLayoutConstraint.activate([
            descriptonTextView.topAnchor.constraint(equalTo: placeTextField.bottomAnchor, constant: 12)
        ])
        descriptonTextView.leading(24)
        descriptonTextView.trailing(-24)
        descriptonTextView.height(100)
        
        NSLayoutConstraint.activate([
            raceImageView.topAnchor.constraint(equalTo: descriptonTextView.bottomAnchor, constant: 12)
        ])
        raceImageView.leading(24)
        raceImageView.trailing(-24)
        raceImageView.height(180)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: raceImageView.bottomAnchor, constant: 12)
        ])
        addButton.leading(24)
        addButton.trailing(-24)
        addButton.height(42)
    }
    
    func setupDatePicker() {
        let dateFromPicker = setupDate()
        let dateToPicker = setupDate()
        dateFromPicker.addTarget(self, action: #selector(dateFromChange(datePicker:)),
                             for: UIControl.Event.valueChanged)
        dateToPicker.addTarget(self, action: #selector(dateToChange(datePicker:)),
                               for: UIControl.Event.valueChanged)
        
        dateFromTextField.setupInputView(with: dateFromPicker)
        dateToTextField.setupInputView(with: dateToPicker)
    }
    
    func setupDate() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = Date()
        datePicker.center = self.center
        return datePicker
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    @objc
    func dateFromChange(datePicker: UIDatePicker){
        dateFromTextField.setupText(with: formatDate(date: datePicker.date))
    }
    
    @objc
    func dateToChange(datePicker: UIDatePicker) {
        dateToTextField.setupText(with: formatDate(date: datePicker.date))
    }
    
    func setupActions() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapToHide)
    }
    
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func setCloseAction(_ action: @escaping CloseClosure) {
        self.closeAction = action
    }
    
    func setAddAction(_ action: @escaping AddClosure) {
        self.addAction = action
    }
    
    @objc
    func closeButtonTapped() {
        closeAction?()
    }
    
    @objc
    func addButtonTapped() {
        var addRaceInfo: [String?] = ["name","datefrom", "dateto", "place", "description"]
        addRaceInfo[0] = eventNameTextField.returnTextFromTF()
        addRaceInfo[1] = dateFromTextField.returnTextFromTF()
        addRaceInfo[2] = dateToTextField.returnTextFromTF()
        addRaceInfo[3] = placeTextField.returnTextFromTF()
        if descriptonTextView.text == "" || descriptonTextView.text == R.string.localizable.eventDescription() {
            addRaceInfo[4] = "Описание не было добавлено, обратитесь к организаторам"
        } else {
            addRaceInfo[4] = descriptonTextView.text
            
        }
        addAction?(addRaceInfo)
    }
}

extension AddRaceContentView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == R.color.tfText() {
            textView.text = nil
            textView.textColor = R.color.mainTextColor()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = R.string.localizable.eventDescription()
            textView.textColor = R.color.tfText()
        }
    }
}


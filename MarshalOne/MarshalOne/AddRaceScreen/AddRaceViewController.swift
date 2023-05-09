//
//  AddRaceViewController.swift
//  MarshalOne
//
//  Created by Veronika on 27.02.2023.
//  
//

import UIKit

final class AddRaceViewController: UIViewController {
    private let output: AddRaceViewOutput
    
    private let labels = ["название", "дата начала",
                          "дата окончания","местоположение"]
    
    private let addRaceContenView: AddRaceContentView = {
        let content = AddRaceContentView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private var imagePicker: ImagePicker?
    
    
    init(output: AddRaceViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupImagePicker()
        setupAction()
    }
}

extension AddRaceViewController {
    private func setupUI() {
        view.backgroundColor = R.color.launchScreenColor()
        
        view.addSubview(addRaceContenView)
        
        addRaceContenView.top(isIncludeSafeArea: false)
        addRaceContenView.leading()
        addRaceContenView.trailing()
        addRaceContenView.bottom(isIncludeSafeArea: false)
    }
    
    func setupImagePicker(){
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        addRaceContenView.raceImageView.isUserInteractionEnabled = true
        
        addRaceContenView.raceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                    action: #selector(selectPhoto)))
    }
    
    @objc
    func selectPhoto() {
        imagePicker?.present(from: addRaceContenView.raceImageView)
    }
    
    func setupAction(){
        addRaceContenView.setAddAction { [weak self] info in
            self?.output.didTapAddRace(with: info)
        }
        addRaceContenView.setCloseAction {
            self.output.didTapCloseViewControllerButton()
        }
    }
    
}
extension AddRaceViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.addRaceContenView.raceImageView.image = image
    }
}

extension AddRaceViewController: AddRaceViewInput {
    func showEmptyFields(withIndexes: [Int]) {
        var alertString = "Не заполены поля: "
        for index in withIndexes {
            if index != withIndexes.last {
                alertString.append(contentsOf: "\(labels[index]), ")
            } else {
                alertString.append(contentsOf: "\(labels[index]).")
            }
        }
        let alert = UIAlertController(title: "Заполните поля",
                                      message: alertString,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: R.string.localizable.correct(), style: .default))
        self.present(alert, animated: true)
    }
}

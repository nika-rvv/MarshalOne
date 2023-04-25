//
//  EventViewController.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import UIKit

final class EventViewController: UIViewController, UIGestureRecognizerDelegate {
    private let output: EventViewOutput
    
    private let navigationBar: NavigationBarView = {
        let navBar = NavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.setupConfigForRegisterScreen()
        return navBar
    }()
    
    private let raceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = R.image.loginImage()
        return imageView
    }()
    
    lazy var eventContentView: EventContentView = {
        let event = EventContentView()
        event.translatesAutoresizingMaskIntoConstraints = false
        event.layer.cornerRadius = 16
        event.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return event
    }()
    
    private lazy var backgroundOfContentListView = UIView()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    init(output: EventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureView()
        setupNavBar()
        output.loadRaceInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = raceImageView.frame.height + eventContentView.frame.height
        scrollView.contentSize = CGSize(width: view.frame.width, height: height)
    }
}

extension EventViewController: EventViewInput {
    func setData(raceData: OneRace) {
        
        eventContentView.configureViewWith(mainText: raceData.name,
                                           placeText: "\(raceData.location.longitude)",
                                           dateText: raceData.date.from,
                                           additionalText: raceData.oneRaceDescription)
    }
}

private extension EventViewController {
    func setupViews() {
        self.tabBarController?.tabBar.backgroundColor = R.color.launchScreenColor()
        view.backgroundColor = R.color.launchScreenColor()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(raceImageView)
        view.addSubview(navigationBar)
        contentView.addSubview(eventContentView)
    }
    
    func setupNavBar(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        ])
        
        navigationBar.leading()
        navigationBar.trailing()
        navigationBar.height(80)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        NSLayoutConstraint.activate([
            raceImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        raceImageView.leading()
        raceImageView.trailing()
        raceImageView.height(view.frame.height / 2.2)
        
        
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: raceImageView.bottomAnchor)
        ])
        eventContentView.leading()
        eventContentView.trailing()
        eventContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        //        scrollView.isDirectionalLockEnabled = true
        //        scrollView.alwaysBounceVertical = true
    }
    
    func configureView() {
        navigationBar.delegate = self
    }
}


extension EventViewController: NavigationBarDelegate {
    func backButtonAction() {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.navigationBar.backButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didPressBackButton()
                self?.navigationBar.backButton.alpha = 1
            }
        }
    }
}

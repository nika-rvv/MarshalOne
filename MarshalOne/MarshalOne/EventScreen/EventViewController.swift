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
    
    private let raceImageView: KingfisherImage = {
        let imageView = KingfisherImage(placeHolderType: .event)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
//    private let contentView = UIView()
    
    init(output: EventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
        setupConstraints()
        configureView()
        setupNavBar()
        output.loadRaceInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width, height: eventContentView.height + raceImageView.frame.height)
        scrollView.contentInset.top = navigationBar.frame.height
    }
}

extension EventViewController: EventViewInput {
    func setData(raceData: OneEventInfo) {
        eventContentView.configureViewWith(mainText: raceData.title,
                                           placeName: raceData.placeName,
                                           dateText: raceData.dateSubtitle,
                                           additionalText: raceData.description,
                                           longitude: raceData.longitude,
                                           latitude: raceData.latitude)
        raceImageView.setImage(url: URL(string: "https://onwheels.enula.ru\(raceData.imageId)"))
        scrollView.layoutIfNeeded()
    }
}

private extension EventViewController {
    func setupViews() {
        self.tabBarController?.tabBar.backgroundColor = R.color.launchScreenColor()
        view.backgroundColor = R.color.launchScreenColor()
        
        view.addSubview(scrollView)
        view.addSubview(navigationBar)
                
        scrollView.addSubview(raceImageView)
        scrollView.addSubview(eventContentView)
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
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            raceImageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        ])
        raceImageView.leading()
        raceImageView.trailing()
        raceImageView.height(view.frame.height / 4)
        
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: raceImageView.bottomAnchor)
        ])
        eventContentView.leading()
        eventContentView.trailing()
        eventContentView.width(view.frame.width)
    }
    
    func configureView() {
        navigationBar.delegate = self
    }
    
    func setupActions() {
        eventContentView.setParticipateAction {
            print("participate")
        }
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

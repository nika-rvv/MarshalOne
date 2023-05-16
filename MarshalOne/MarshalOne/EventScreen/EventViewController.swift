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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var eventContentView: EventContentView = {
        let event = EventContentView()
        event.translatesAutoresizingMaskIntoConstraints = false
        event.layer.cornerRadius = 16
        event.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return event
    }()
        
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
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
        setupConstraints()
        configureView()
        setupNavBar()
        setupActions()
        output.loadRaceInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentViewHeight = eventContentView.height + raceImageView.frame.height + 50
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentViewHeight)
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
        
        eventContentView.configureButton(isMember: raceData.isMember)
        raceImageView.setImage(url: URL(string: "\(raceData.imageId)"))
        scrollView.layoutIfNeeded()
    }
    
    func addMember() {
        UIView.animate(withDuration: 0.3) {
            self.eventContentView.configureButton(isMember: true)
        }
    }
    
    func deleteMember() {
        UIView.animate(withDuration: 0.3) {
            self.eventContentView.configureButton(isMember: false)
        }
    }
}

private extension EventViewController {
    func setupViews() {
        self.tabBarController?.tabBar.backgroundColor = R.color.launchScreenColor()
        view.backgroundColor = R.color.tabBarColor()
        
        view.addSubview(scrollView)
        view.addSubview(navigationBar)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(raceImageView)
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.top(isIncludeSafeArea: false)
        contentView.leading()
        contentView.trailing()
        contentView.width(view.frame.width)
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.1)
        ])
        
        NSLayoutConstraint.activate([
            raceImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            raceImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        raceImageView.leading()
        raceImageView.trailing()
        raceImageView.width(contentView.frame.width)
        
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: raceImageView.bottomAnchor),
            eventContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        eventContentView.leading()
        eventContentView.trailing()
        eventContentView.width(contentView.frame.width)
    }
    
    func configureView() {
        navigationBar.delegate = self
    }
    
    func setupActions() {
        eventContentView.setParticipateAction {
            self.output.postParticipant()
        }
        
        eventContentView.unsetParticipateAction {
            self.output.deleteParticipant()
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

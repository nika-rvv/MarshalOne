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
        self.tabBarController?.tabBar.backgroundColor = R.color.launchScreenColor()
        setupViews()
        setupConstraints()
        configureView()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = raceImageView.frame.height + eventContentView.frame.height
        scrollView.contentSize = CGSize(width: view.frame.width, height: height)
    }
}

extension EventViewController: EventViewInput {
    private func setupViews() {
        view.backgroundColor = R.color.launchScreenColor()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(raceImageView)
        raceImageView.backgroundColor = .red
                view.addSubview(navigationBar)
        contentView.addSubview(eventContentView)
    }
    
    private func setupConstraints(){
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
    
    private func configureView() {
        navigationBar.delegate = self
        eventContentView.configureViewWith(mainText: "Чемпионат России. Гонки на льду - класс 500. Полуфинал - 1 этап",
                                           placeText: "респ. Башкортостан, Уфа",
                                           dateText: "7 янв. — 10 янв.",
                                           additionalText: "Пролог в темное время: часовой (эндуро-стадион + небольшой трек для хуй классов Pro и B3. Наличие фары, фонариков - спереди, заднего габарита либо отражающих элементов красного цвета - ОБЯЗАТЕЛЬНО. Первый внедорожный гоночный день классов Profi (Pro) (сложность трека - heavy) и Base 3 (B3) (сложность трека - medium).")
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

//
//  EnterViewController.swift
//  MarshalOne
//
//  Created by Veronika on 09.02.2023.
//  
//

import UIKit

final class EnterViewController: UIViewController {
	private let output: EnterViewOutput

    var timer = Timer()
    let timeInterval = 1.0
    
    let lauchImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .launchImage
        return image
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = .mainOrangeColor
        progress.trackTintColor = .cellColor
        progress.layer.cornerRadius = 6
        progress.clipsToBounds = true
        progress.progress = 0
//        progress.heightAnchor.constraint(equalToConstant: 7)
        return progress
    }()
    
    init(output: EnterViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(nextView),
                                     userInfo: nil, repeats: false)
	}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupProgressView()
    }
    
    @objc
    func nextView(){
        output.showNextScreen()
    }
}

extension EnterViewController {
    func setupConstraints(){
        view.backgroundColor = .screenColor

        view.addSubview(lauchImage)
        lauchImage.centerX()
        lauchImage.centerY()
        lauchImage.leading(60)
        lauchImage.trailing(-60)
        
        view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: lauchImage.bottomAnchor, constant: 50)
        ])
        progressView.leading(60)
        progressView.trailing(-60)
        progressView.height(10)
    }
    
    func setupProgressView(){
        UIView.animate(withDuration: timeInterval) {
            self.progressView.setProgress(Float(self.timeInterval), animated: true)
        }
    }
}

extension EnterViewController: EnterViewInput {
}

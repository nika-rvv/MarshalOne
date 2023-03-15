import UIKit

class ViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var startingHeight: CGFloat = 0
    private var bottomSheetYPositionConstraint: NSLayoutConstraint!
    private var bottomSheetHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(bottomSheetView)
        
        addConstraints()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler))
        bottomSheetView.addGestureRecognizer(panGesture)
        
        startingHeight = view.frame.height - bottomSheetYPositionConstraint.constant
    }
    
    private func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        bottomSheetYPositionConstraint = bottomSheetView.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        bottomSheetHeightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: 300)
        
        NSLayoutConstraint.activate([
            bottomSheetYPositionConstraint,
            bottomSheetHeightConstraint,
            bottomSheetView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    @objc private func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        switch sender.state {
        case .began:
            break
        case .changed:
            let height = max(view.frame.height - translation.y, startingHeight)
            bottomSheetHeightConstraint.constant = height
        case .ended, .cancelled:
            let currentHeight = view.frame.height - translation.y
            let ratio = currentHeight / view.frame.height
            let shouldClose = ratio < 0.5
            let newHeight = shouldClose ? startingHeight : view.frame.height + bottomSheetHeightConstraint.constant
            bottomSheetHeightConstraint.constant = newHeight
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        default:
            break
        }
    }
}

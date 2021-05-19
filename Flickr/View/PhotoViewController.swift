import UIKit

class PhotoViewController: UIViewController {
    var image: UIImage!
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var photoView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()

        photoView.image = image
    }
    
    private func setUpLayout() {
        
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(photoView)

        closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        photoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        photoView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true
        photoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    // MARK: - Navigation
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

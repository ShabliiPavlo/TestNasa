
import UIKit

class ViewPhotoViewController: UIViewController {
    
    var imageScrollView: ImageScrollView!
    var uiimage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let image = uiimage {
                    imageScrollView = ImageScrollView(frame: view.bounds)
                    view.addSubview(imageScrollView)
                    setupImageScrollView()
                    imageScrollView.set(image: image)
                }
        setupButon()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupImageScrollView() {
            imageScrollView.translatesAutoresizingMaskIntoConstraints = false
            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        }
    
    func setupButon() {
        let closeButton = UIButton(type: .system)
        closeButton.setImage(.close, for: .normal)
        closeButton.backgroundColor = .clear
        closeButton.tintColor = .white
                closeButton.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
                closeButton.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(closeButton)
            
                NSLayoutConstraint.activate([
                    closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                    closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                    closeButton.widthAnchor.constraint(equalToConstant: 40),
                    closeButton.heightAnchor.constraint(equalToConstant: 40)
                ])
    }
}

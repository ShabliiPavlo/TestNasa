import UIKit
import Lottie
import SnapKit

class AppLoaderViewController: UIViewController {

    var animationView: LottieAnimationView?
    var squareImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAnimationView()
        setupSquareImageView()
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            let vc =  UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ListOfMarsCamerasViewController")

            self.view.window?.rootViewController = UINavigationController(rootViewController: vc)
            self.view.window?.makeKeyAndVisible()
            
        }
    }
    
    func loadAnimationView() {
        animationView = .init(name: "loader")
        view.addSubview(animationView!)

        animationView?.snp.makeConstraints { make in
            make.width.equalTo(555)
            make.height.equalTo(168)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
        
        animationView?.loopMode = .loop
        animationView?.play()
    }
    
    func setupSquareImageView() {
           let imageSize: CGFloat = 200
        squareImageView = UIImageView(image: UIImage(named: "launchScreenView"))
           squareImageView?.backgroundColor = .clear
           view.addSubview(squareImageView!)
           
           squareImageView?.translatesAutoresizingMaskIntoConstraints = false
           squareImageView?.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
           squareImageView?.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
           squareImageView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           squareImageView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       }
}


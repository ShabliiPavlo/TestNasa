
import UIKit

class ViewPhotoViewController: UIViewController {

    @IBOutlet weak var marsPhoto: UIImageView!
    
    var uiimage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.marsPhoto.image = uiimage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func close(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

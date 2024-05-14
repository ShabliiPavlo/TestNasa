
import UIKit
import SDWebImage

class MarsDataTableViewCell: UITableViewCell {
    
    var reuseID = String(describing: MarsDataTableViewCell.self)
    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var rover: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var camera: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configureWith(imageData:String) {
        let posterURL = URL(string: imageData)
        imageViewCell.sd_setImage(with: posterURL)
    }
    
    func hostoryCellConfig(model: HostoryCellModel) {
        rover.text = model.rover
        date.text = model.date
        camera.text = model.camera
    }
}

extension MarsDataTableViewCell {
    
    func setupUI() {
        setupBackgroundViewCell()
        setupImageViewCell()
    }
    
    func setupBackgroundViewCell() {
        backgroundViewCell.layer.cornerRadius = 20
    }
    
    func setupImageViewCell() {
        imageViewCell.layer.cornerRadius = 20
    }
    
    func configureOtherCell(roverName: String,
                            day: String,
                            cameraName: String) {

        let attributedTextRover = NSMutableAttributedString(string: "Rover: ", attributes: [
            .font: UIFont(name: "SFPro-Regular", size: 16) as Any,
            .foregroundColor: UIColor.layerTwo
        ])
        attributedTextRover.append(NSAttributedString(string: roverName, attributes: [
            .font: UIFont(name: "SFPro-Bold", size: 17) as Any,
            .foregroundColor: UIColor.layerOne
        ]))
        
        rover.attributedText = attributedTextRover
        
        let attributedTextDay = NSMutableAttributedString(string: "Date: ", attributes: [
            .font: UIFont(name: "SFPro-Regular", size: 16) as Any,
            .foregroundColor: UIColor.layerTwo
        ])
        attributedTextDay.append(NSAttributedString(string: day, attributes: [
            .font: UIFont(name: "SFPro-Bold", size: 17) as Any,
            .foregroundColor: UIColor.layerOne
        ]))
        
        date.attributedText = attributedTextDay
        
        let attributedText = NSMutableAttributedString(string: "Camera: ", attributes: [
            .font: UIFont(name: "SFPro-Regular", size: 16) as Any,
            .foregroundColor: UIColor.layerTwo
        ])
        attributedText.append(NSAttributedString(string: cameraName, attributes: [
            .font: UIFont(name: "SFPro-Bold", size: 17) as Any,
            .foregroundColor: UIColor.layerOne
        ]))
        
        camera.attributedText = attributedText
    }
}




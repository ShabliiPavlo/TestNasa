//
//  HistoryTableViewCell.swift
//  90210
//
//  Created by Pavel Shabliy on 14.05.2024.
//

import UIKit



class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgrounViewCell: UIView!
    @IBOutlet weak var filtersButon: UIButton!
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var deleteAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func filtersButtonPress(_ sender: Any) {
        deleteAction?()
    }
    
    func hostoryCellConfig(model: HostoryCellModel) {
        roverLabel.text = model.rover
        dateLabel.text = model.date.formatDate()
        cameraLabel.text = model.camera
    }
}

extension HistoryTableViewCell {
    
    func setupUI() {
        setupBackgroun()
        setupFiltersButton()
    }
    
    func setupBackgroun() {
        backgrounViewCell.layer.cornerRadius = 30
    }
    
    func setupFiltersButton() {
        filtersButon.setTitle("Filters", for: .normal)
        filtersButon.titleLabel?.font = UIFont(name: "SFPro-Bold",
                                               size: 22)
    }
}


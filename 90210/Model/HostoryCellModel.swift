
import Foundation

struct HostoryCellModel {
    var rover: String
    var camera: String
    var date: String
    var image: String
    
    
    init(relmModel: RealmItemModel) {
        self.rover = relmModel.rover
        self.camera = relmModel.camera
        self.date = relmModel.date
        self.image = relmModel.imageKeyString
    }
    
     init(model: RealmFilterModel) {
        self.rover = model.roverType
        self.camera = model.cameraType
        self.date = model.date
        self.image = ""
    }
}

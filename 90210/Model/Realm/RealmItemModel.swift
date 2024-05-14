
import Foundation
import RealmSwift

final class RealmItemModel: Object {
    @Persisted(primaryKey: true) var realmKey: String = ""
    @Persisted var rover: String
    @Persisted var imageKeyString: String
    @Persisted var date: String
    @Persisted var camera: String
    
    convenience init(model: Photo) {
        self.init()
        self.realmKey = UUID().uuidString
        self.rover = model.rover.name
        self.date = model.rover.launchDate
        self.camera = model.camera.name
        self.imageKeyString = model.imgSrc
    }
}



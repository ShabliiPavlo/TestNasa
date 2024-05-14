
import Foundation
import RealmSwift

final class RealmFilterModel: Object {
    @Persisted var roverType: String
    @Persisted var cameraType: String
    @Persisted var date: String
    
    convenience init(roverType: RoverType,
                     cameraType: Abbreviation,
                     date: String) {
        self.init()
        self.roverType = roverType.rawValue
        self.cameraType = cameraType.rawValue
        self.date = date
    }
}


import Foundation
import RealmSwift

final class RealmManager {
    
    private var realm: Realm? {
        do {
            return try Realm()
        } catch let error as NSError {
            print("realm init error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func createObject<T: Object>(_ object: T) {
        do {
            try realm?.write({
                realm?.add(object)
            })
            
            print(self.getAllObjects(type: RealmItemModel.self).count)
        } catch {
            print("create object error: \(error)")
        }
    }
    
    func getAllObjects<T:Object>(type: T.Type) -> [T] {
        guard let realm = realm else {
            return []
        }
        return Array(realm.objects(type))
    }
    
    func readObjects<T: Object>(type: T.Type) -> Results<T>? {
        return realm?.objects(type)
    }
    
}

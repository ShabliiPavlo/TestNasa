
import Foundation


 class HistoryViewModel {
     weak var delegate: ListOfMarsCamerasViewModelProtocol?
    
    var realmManager: RealmManager
    
    var history: [HostoryCellModel] = []
    
     var vcType: HistoryType
     init(realmManager: RealmManager, type: HistoryType) {
        self.realmManager = realmManager
         self.vcType = type
    }
    
     func vcStart() {
         history = []

         switch vcType {
         case .filter:
             realmManager.readObjects(type: RealmFilterModel.self)?.forEach { model in
                 self.history.append(HostoryCellModel(model: model))
             }
         case .items:
             realmManager.readObjects(type: RealmItemModel.self)?.forEach { model in
                 self.history.append(HostoryCellModel(relmModel: model))
             }
         }
         delegate?.reloadDataTable()
     }
     
     func deleteHistoryItem(at index: Int) {
             switch vcType {
             case .filter:
                 if let objects = realmManager.readObjects(type: RealmFilterModel.self) {
                     let objectToDelete = objects[index]
                     realmManager.deleteObject(objectToDelete)
                 }
             case .items:
                 if let objects = realmManager.readObjects(type: RealmItemModel.self) {
                     let objectToDelete = objects[index]
                     realmManager.deleteObject(objectToDelete)
                 }
             }
             history.remove(at: index)
             delegate?.reloadDataTable()
         }
}


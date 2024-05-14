
import Foundation


 class TestViewModel {
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
}


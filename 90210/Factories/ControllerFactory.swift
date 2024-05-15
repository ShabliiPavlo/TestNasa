
import Foundation

protocol ControllerFactoryProtocol  {
    static func listOfMarsViewController() -> ListOfMarsCamerasViewController
    static func appLoaderViewController() -> AppLoaderViewController
    static func testViewController(vcType: HistoryType) -> HistoryViewController
}

final class ControllerFactory: ControllerFactoryProtocol {
    static func testViewController(vcType: HistoryType) -> HistoryViewController {
        let realm = RealmManager()
        let viewModel = HistoryViewModel(realmManager: realm, type: vcType)
        return HistoryViewController(testViewModel: viewModel)
    }
    
    static func appLoaderViewController() -> AppLoaderViewController {
        return AppLoaderViewController()
    }
    
    static func listOfMarsViewController() -> ListOfMarsCamerasViewController {
        let network = NetworkManager()
        let realm = RealmManager()
        let viewModel = ListOfMarsCamerasViewModel(network: network, realmManager: realm)
        return ListOfMarsCamerasViewController(viewModel: viewModel)
    }

}

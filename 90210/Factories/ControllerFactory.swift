
import Foundation

protocol ControllerFactoryProtocol  {
    static func listOfMarsViewController() -> ListOfMarsCamerasViewController
    static func appLoaderViewController() -> AppLoaderViewController
    static func testViewController(vcType: HistoryType) -> TestViewController
}

final class ControllerFactory: ControllerFactoryProtocol {
    static func testViewController(vcType: HistoryType) -> TestViewController {
        let realm = RealmManager()
        let viewModel = TestViewModel(realmManager: realm, type: vcType)
        return TestViewController(testViewModel: viewModel)
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

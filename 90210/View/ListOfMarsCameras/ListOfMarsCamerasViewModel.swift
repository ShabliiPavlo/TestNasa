
import Foundation
import Combine
import DataCache

protocol ListOfMarsCamerasViewModelProtocol: AnyObject {
    func filterCameraButtonTapped()
    func reloadDataTable()
}

class ListOfMarsCamerasViewModel {
    
    var networkManage: NetworkManager
    var realmManager: RealmManager
    
    var delegate: ListOfMarsCamerasViewModelProtocol?
    var nasaManagerData: [Photo] = [] {
        didSet {
    
        }
    }

    private var selectedCameraSubject = PassthroughSubject<Abbreviation, Never>()
    private var selectedRoverSubject = PassthroughSubject<RoverType, Never>()
    private var dateSubject = PassthroughSubject<String?, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    public var camera: Abbreviation = .All
    public var rover: RoverType = .curiosity
    public var date: String? = "2016-05-12"
      
    init(network: NetworkManager, realmManager: RealmManager) {
        self.networkManage = network
        self.realmManager = realmManager
        combineSub()
    }
    
    func saveObjectToRealm(indexPath: IndexPath) {
        realmManager.createObject(RealmItemModel(model: self.nasaManagerData[indexPath.row]))
    }
    
    func saveHistorFilter() {
        realmManager.createObject(RealmFilterModel(roverType: rover, cameraType: camera, date: date ?? "date error"))
    }
    
    func getImage(index: Int) async throws -> Data? {
            let item = nasaManagerData[index]

            if let data = DataCache.instance.readData(forKey: item.imgSrc) {
                return data
            } else {
                do {
                    let imageData = try await networkManage.loadImageData(item: item.imgSrc)
                    DataCache.instance.write(data: imageData, forKey: item.imgSrc)
                    return imageData
                } catch {
                    throw NetworkError.custome(error.localizedDescription)
                }

            }
        }
    
}

extension ListOfMarsCamerasViewModel {
    func requestDataStartApp() {
        requestData(camera: .All, rover: .curiosity, date: "2016-05-12")
    }
    
    func requestData(camera: Abbreviation, rover: RoverType, date: String?) {
        self.nasaManagerData.removeAll()
        networkManage.requestData(camera: camera, date: date ?? "2016-05-12", rover: rover, completion: { data in
            self.nasaManagerData.append(contentsOf: data.photos)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                self.delegate?.reloadDataTable()
            }
        })
    }
    
    func setSelectedCamera(_ camera: Abbreviation) {
        self.camera = camera
        selectedCameraSubject.send(camera)
    }
    
    func setSelectedRover(_ rover: RoverType) {
        self.rover = rover
        selectedRoverSubject.send(rover)
    }
    
    func setDate(_ date: String?) {
        self.date = date
        dateSubject.send(date)
    }
}

extension ListOfMarsCamerasViewModel {
     func combineSub() {
        selectedCameraSubject
            .sink { cam in
                self.requestData(camera: cam, rover: self.rover, date: self.date)
            }
            .store(in: &cancellables)
        
        selectedRoverSubject
            
            .sink { rover in
                self.requestData(camera: self.camera, rover: rover, date: self.date)
                
            }
            .store(in: &cancellables)
        
        dateSubject
            .sink {  date in
                self.requestData(camera: self.camera, rover: self.rover, date: date)
                
            }
            .store(in: &cancellables)
    }
    
    func requestData(with model: HostoryCellModel) {
           let camera = Abbreviation.allCases.first { $0.rawValue == model.camera } ?? .All
           let rover = RoverType.allCases.first { $0.rawValue == model.rover } ?? .curiosity
           requestData(camera: camera, rover: rover, date: model.date)
       }
}
enum NetworkError: Error {
    case imageLoadingError
    case custome(String)
}

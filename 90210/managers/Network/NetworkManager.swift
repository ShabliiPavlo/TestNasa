
import UIKit
import Alamofire
import DataCache

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func requestData(camera: Abbreviation, date: String, rover: RoverType, completion: @escaping (NasaApiModel) -> Void) {
        let cam = camera == .All ? "" : "&camera=\(camera.rawValue.lowercased())"
        let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover.rawValue)/photos?&earth_date=\(date)\(cam)&api_key=fmJzGmXJDMDLfIHRx7Ag9viVFvK4ej8NcOcBsyKk"
        
        if let cachedData: NasaApiModel = try? DataCache.instance.readCodable(forKey: url) {
            completion(cachedData)
        } else {
            AF.request(url).responseDecodable(of: NasaApiModel.self) { response in
                switch response.result {
                case .success(let allData):
                    completion(allData)
                    do {
                        try DataCache.instance.write(codable: allData, forKey: url)
                    } catch {
                        print("Error writing to cache: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

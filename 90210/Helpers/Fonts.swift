
import UIKit

enum FontSizes {
    case bigTitle
    case title
    case body
    case info

    var size: CGFloat {
        switch self {
        case .bigTitle:
            return 34
        case .title:
            return 22
        case .body:
            return 17
        case .info:
            return 16
        }
    }
}

extension UIFont {
    
    static func sfProBold(_ size: FontSizes) -> UIFont {
        UIFont(name: "SFPro-Bold", size: size.size) ?? .systemFont(ofSize: size.size, weight: .semibold)
    }
    
    static func sfProRegular(_ size: FontSizes) -> UIFont {
        UIFont(name: "SFPro-Regular", size: size.size) ?? .systemFont(ofSize: size.size)
    }
}

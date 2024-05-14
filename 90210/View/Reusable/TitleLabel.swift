
import UIKit

class TitleLabel: UILabel {
    init(text: String, style: Style) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .left
        self.numberOfLines = 0
        self.textColor = style.textColor
        self.font = style.font
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TitleLabel {
    struct Style {
        let textColor: UIColor
        let font: UIFont
        
        static let largeTitle = Style(
            textColor: .layerOne,
            font:  .sfProBold(.bigTitle)
        )
        
        static let secondTitle = Style(
            textColor: .layerOne,
            font:  .sfProBold(.title)
        )
        
        static let title = Style(
            textColor: .layerTwo,
            font: .sfProRegular(.title)
        )
        
        static let secondBody = Style(
            textColor: .layerOne,
            font: .sfProBold(.body)
        )
        
        static let body = Style(
            textColor: .layerTwo,
            font: .sfProRegular(.info)
        )
    }
}



import UIKit

extension UITableView {
    func scrolToTopItem() {
        guard numberOfSections > 0 else { return }
        guard numberOfRows(inSection: 0) > 0 else { return }
        scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

extension String {
    func formatDate() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }

}


import UIKit

extension UITableView {
    func scrolToTopItem() {
        guard numberOfSections > 0 else { return }
        guard numberOfRows(inSection: 0) > 0 else { return }
        scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

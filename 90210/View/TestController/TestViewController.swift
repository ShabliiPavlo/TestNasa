
import UIKit

enum HistoryType {
    case filter
    case items
}

class TestViewController: UIViewController {

    lazy var tableViewMars: UITableView = {
        var v = UITableView()
        let nib = UINib(nibName: "MarsDataTableViewCell", bundle: nil)
        v.register(nib, forCellReuseIdentifier: "MarsDataTableViewCell")

        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    let testViewModel: TestViewModel
    
    init(testViewModel: TestViewModel) {
        self.testViewModel = testViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testViewModel.vcStart()
        testViewModel.delegate = self
        view.addSubview(tableViewMars)
        tableViewMars.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
       
    }
}
extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testViewModel.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarsDataTableViewCell", for: indexPath) as? MarsDataTableViewCell else { return UITableViewCell()}
        cell.hostoryCellConfig(model:testViewModel.history[indexPath.item])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
}

extension TestViewController: ListOfMarsCamerasViewModelProtocol {
    func filterCameraButtonTapped() {
        
    }
    
    func reloadDataTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableViewMars.reloadData()

        }
    }
}

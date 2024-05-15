
import UIKit

enum HistoryType {
    case filter
    case items
}

class HistoryViewController: UIViewController {
    
    let headerView = UIView()
    let tittleOfHeader = TitleLabel(text: "History",
                                    style: .largeTitle)
    let backgroundImageView = UIImageView()
    
    lazy var tableViewMars: UITableView = {
        var v = UITableView()
        let nib = UINib(nibName: "MarsDataTableViewCell", bundle: nil)
        v.register(nib, forCellReuseIdentifier: "MarsDataTableViewCell")
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    let testViewModel: HistoryViewModel
    var request: ((HostoryCellModel)->Void)?
    
    init(testViewModel: HistoryViewModel) {
        self.testViewModel = testViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        testViewModel.vcStart()
        testViewModel.delegate = self
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension HistoryViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        setupHeaderView()
        setupTableView()
        setupTitleLabel()
        setupBackButton()
        setupBackgroundImageView()
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        headerView.backgroundColor = .accentOne
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.15)
        }
    }
    
    func setupTableView() {
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableViewMars.register(nib, forCellReuseIdentifier: "HistoryTableViewCell")
        tableViewMars.separatorStyle = .none
        view.addSubview(tableViewMars)
        tableViewMars.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupTitleLabel() {
        headerView.addSubview(tittleOfHeader)
        tittleOfHeader.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(headerView.snp.bottom).multipliedBy(0.7)
        }
    }
    
    func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "close"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.backgroundColor = .clear
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalTo(tittleOfHeader)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "emptyBg")
        backgroundImageView.contentMode = .scaleAspectFit
        
        let screenWidth = UIScreen.main.bounds.width
        let imageSize = screenWidth * 0.3
        
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(imageSize)
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = testViewModel.history.count
        tableView.isHidden = numberOfRows == 0
        backgroundImageView.isHidden = numberOfRows > 0
        return testViewModel.history.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? HistoryTableViewCell else { return }
        let alert = UIAlertController(title: "", message: "Menu Filter", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Use", style: .default, handler: { _ in
            self.request?(self.testViewModel.history[indexPath.item])
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.testViewModel.deleteHistoryItem(at: indexPath.row)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell()}
        cell.deleteAction = { [weak self] in
            guard let self = self else { return }
            self.testViewModel.deleteHistoryItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        cell.hostoryCellConfig(model:testViewModel.history[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
}

extension HistoryViewController: ListOfMarsCamerasViewModelProtocol {
    func filterCameraButtonTapped() {
        
    }
    
    func reloadDataTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableViewMars.reloadData()
        }
    }
}

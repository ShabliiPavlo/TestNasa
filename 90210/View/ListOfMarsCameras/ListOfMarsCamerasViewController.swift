
import UIKit
import SnapKit
import SDWebImage

class ListOfMarsCamerasViewController: UIViewController {
    
    let headerView = UIView()
    let dimmingView = UIView()
    let filterCameraButton = UIButton()
    let filterRoverButton = UIButton()
    let seveFilterButton = UIButton()
    lazy var calendarButton = UIButton()
    let stackView = UIStackView()
    let dateLabel = TitleLabel(text: "2016-05-12",
                               style: .secondBody)
    let tittleOfHeader = TitleLabel(text: "MARS.CAMERA",
                                    style: .largeTitle)

    var date: String?
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var marsDataTableView: UITableView!
    @IBOutlet weak var backgroundPickerView: UIView!
    @IBOutlet weak var backgroundPicker: UIView!
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var cameraPicker: UIPickerView!
    @IBOutlet weak var roverPicker: UIPickerView!
    
    @IBOutlet weak var backgroundDatePicker: UIView!
    @IBOutlet weak var backgroundDatePickerLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var viewModel: ListOfMarsCamerasViewModel
    
    var selectedCamera: Abbreviation?
    var selectedRover: RoverType?

    init(viewModel: ListOfMarsCamerasViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ListOfMarsCamerasViewModel(network: NetworkManager(), realmManager: RealmManager())
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestDataStartApp()
        viewModel.delegate = self
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func historyButtonPress(_ sender: Any) {
        let alert = UIAlertController(title: "History",
                                      message: "",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        let toHistoryItems = UIAlertAction(title: "Revise", 
                                           style: .destructive) { _ in
            let vc = ControllerFactory.testViewController(vcType: .items)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let toHistoryFilters = UIAlertAction(title: "Filters", style: .destructive) { _ in
            let vc = ControllerFactory.testViewController(vcType: .filter)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }

        alert.addAction(toHistoryItems)
        alert.addAction(toHistoryFilters)

        navigationController?.present(alert, animated: true)
    }
    
    @IBAction func closePickerButtonPress(_ sender: Any) {
        self.backgroundPicker.isHidden = true
        self.cameraPicker.isHidden = true
        self.roverPicker.isHidden = true
    }
    
    @IBAction func selectPickerButtonPress(_ sender: Any) {
        self.backgroundPicker.isHidden = true
        self.cameraPicker.isHidden = true
        self.roverPicker.isHidden = true

        DispatchQueue.main.async { [self] in
            if let selectedCamera  {
                viewModel.setSelectedCamera(selectedCamera)
                filterCameraButton.setTitle("\(selectedCamera)", for: .normal)
            }

            if let selectedRover {
                viewModel.setSelectedRover(selectedRover)
                filterRoverButton.setTitle(selectedRover.rawValue, for: .normal)
            }
        }
    }
    
    @IBAction func closeDatePickerButtonPress(_ sender: Any) {

        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 0
        } completion: { _ in
            self.dimmingView.isHidden = true
        }
        self.backgroundPicker.isHidden = true
    }
    
    @IBAction func selectDatePickerButtonPress(_ sender: Any) {

        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 0
        } completion: { _ in
            self.dimmingView.isHidden = true
        }
        self.backgroundPicker.isHidden = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(for: datePicker.date)
        
        dateLabel.text = formattedDate
        viewModel.setDate(formattedDate)
    }
    
    private func showSaveFilterAlert() {
        let alert = UIAlertController(title: "Save Filters", message: "The current filters and the date you have chosen can be saved to the filter history.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            self.viewModel.saveHistorFilter()
        }

        alert.addAction(cancelAction)
        alert.addAction(save)

        navigationController?.present(alert, animated: true)
    }
}

extension ListOfMarsCamerasViewController {
    
    func setupUI() {
        setupBgView()
        setupNavigationItem()
        setupHeaderView()
        setupDimmingView()
        setupButtons()
        setupTitleLabel()
        setupDateLabel()
        setupTableView()
        setupBackgroundPicker()
        setupBackgroundDatePicker()
    }
    
    func setupBgView() {
        view.backgroundColor = . backgroundOne
    }
    
    func setupNavigationItem() {
        navigationItem.hidesBackButton = true
    }
    
    func setupDimmingView() {
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        dimmingView.isHidden = true
        view.addSubview(dimmingView)
        dimmingView.frame = view.bounds
    }
    
    func setupHeaderView() {
        headerView.backgroundColor = .accentOne
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.22)
        }
    }
    
    func setupTitleLabel() {
        headerView.addSubview(tittleOfHeader)
        tittleOfHeader.snp.makeConstraints { make in
            make.centerY.equalTo(calendarButton.snp.centerY)
            make.left.equalTo(headerView).offset(19)
        }
    }
    
    func setupDateLabel() {
        headerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(tittleOfHeader.snp.bottom).offset(8)
            make.left.equalTo(headerView).offset(19)
        }
    }
    
    func setupButtons() {
        filterCameraButton.setImage(.camera, for: .normal)
        filterCameraButton.backgroundColor = .backgroundOne
        filterCameraButton.layer.cornerRadius = 10
        filterCameraButton.setTitle("All", for: .normal)
        filterCameraButton.setTitleColor(.black, for: .normal)
        filterCameraButton.titleLabel?.font = UIFont(name: "SFPro-Bold",
                                                     size: 22)
        filterCameraButton.addAction(UIAction { _ in
            self.backgroundPicker.isHidden = false
            self.cameraPicker.isHidden = false
            self.roverPicker.isHidden = true
            self.pickerLabel.text = "Camera"
            self.pickerLabel.font = UIFont(name: "SFPro-Bold",
                                           size: 22)
        }, for: .touchUpInside)
        
        filterRoverButton.setImage(.rover, for: .normal)
        filterRoverButton.backgroundColor = .backgroundOne
        filterRoverButton.layer.cornerRadius = 10
        filterRoverButton.setTitle("curiosity", for: .normal)
        filterRoverButton.setTitleColor(.black, for: .normal)
        filterRoverButton.titleLabel?.font = UIFont(name: "SFPro-Bold",
                                                    size: 22)
        filterRoverButton.addAction(UIAction { _ in
            self.backgroundPicker.isHidden = false
            self.cameraPicker.isHidden = true
            self.roverPicker.isHidden = false
            self.pickerLabel.text = "Rover"
            self.pickerLabel.font = UIFont(name: "SFPro-Bold",
                                           size: 22)
        }, for: .touchUpInside)
        
        seveFilterButton.setImage(.saveFilter, for: .normal)
        seveFilterButton.backgroundColor = .backgroundOne
        seveFilterButton.layer.cornerRadius = 10
        
        seveFilterButton.addAction(
            UIAction { _ in
                self.showSaveFilterAlert()
            }, for: .touchUpInside)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        stackView.addArrangedSubview(filterRoverButton)
        stackView.addArrangedSubview(filterCameraButton)
        
        headerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(75)
            make.height.equalTo(headerView.snp.height).multipliedBy(0.2)
        }
        
        headerView.addSubview(seveFilterButton)
        seveFilterButton.snp.makeConstraints { make in
            make.bottom.equalTo(headerView).offset(-10)
            make.right.equalTo(headerView).offset(-10)
            make.width.equalTo(stackView.snp.height)
            make.height.equalTo(stackView.snp.height)
        }
        dimmingView.addSubview(backgroundDatePicker)
        headerView.addSubview(calendarButton)
        calendarButton.backgroundColor = .clear
        calendarButton.setImage(.calendar, for: .normal)
        calendarButton.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).offset(-45)
            make.centerX.equalTo(seveFilterButton.snp.centerX)
            make.width.equalTo(seveFilterButton.snp.width)
            make.height.equalTo(seveFilterButton.snp.height)
        }
        
        calendarButton.addAction(UIAction { _ in
            self.dimmingView.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.dimmingView.alpha = 1
            }
            self.backgroundDatePicker.isHidden = false
        }, for: .touchUpInside)
        
        historyButton.layer.cornerRadius = 35
    }

    func setupBackgroundDatePicker() {
        backgroundDatePicker.layer.cornerRadius = 50
    }
    
    func setupTableView() {
        let nib = UINib(nibName: "MarsDataTableViewCell", bundle: nil)
        marsDataTableView.register(nib, forCellReuseIdentifier: "MarsDataTableViewCell")
        marsDataTableView.separatorStyle = .none
    }
    
    func setupBackgroundPicker() {
        backgroundPicker.layer.cornerRadius = 40
    }
}

extension ListOfMarsCamerasViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MarsDataTableViewCell else { return }
        guard let deteil = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ViewPhotoViewController") as? ViewPhotoViewController else { return}

        viewModel.saveObjectToRealm(indexPath: indexPath)
        deteil.uiimage = cell.imageViewCell.image
        self.navigationController?.pushViewController(deteil, animated: true)

    }
}

extension ListOfMarsCamerasViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.nasaManagerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarsDataTableViewCell") as?  MarsDataTableViewCell else { return UITableViewCell()}
        let imageURL = viewModel.nasaManagerData[indexPath.row].imgSrc
        let roverData = viewModel.nasaManagerData[indexPath.row].rover.name
        let dayData = viewModel.nasaManagerData[indexPath.row].earthDate
        let cameraData = viewModel.nasaManagerData[indexPath.row].camera.fullName
        Task {
                    if let imageDat = try await viewModel.getImage(index: indexPath.row) {
                        cell.configureWith(imageData: imageDat)
                    }
                }
        cell.configureOtherCell(roverName: roverData, day: dayData, cameraName: cameraData)
        return cell
    }
}

extension ListOfMarsCamerasViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cameraPicker {
            return Abbreviation.allCases.count
        } else if pickerView == roverPicker {
            return RoverType.allCases.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cameraPicker {
            return Abbreviation.allCases[row].abbreviationTitle
        } else if pickerView == roverPicker {
            return RoverType.allCases[row].rawValue
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cameraPicker {
            let selectedCamera = Abbreviation.allCases[row]
            self.selectedCamera = selectedCamera
        } else if pickerView == roverPicker {
            let selectedRover = RoverType.allCases[row]
            self.selectedRover = selectedRover
        }
    }
}

extension ListOfMarsCamerasViewController: ListOfMarsCamerasViewModelProtocol {
    func filterCameraButtonTapped() {
        
    }
    
    func reloadDataTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            marsDataTableView.scrolToTopItem()
            self.marsDataTableView.reloadData()
        }
    }
}


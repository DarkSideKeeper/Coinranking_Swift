import UIKit
import RxSwift
import RxCocoa
import UIScrollView_InfiniteScroll
import Alamofire

class MainVC: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldClearButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let topRefreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    private let topRankCell = TopRankTableViewCell.getClassName()
    private let normalCell = NormalTableViewCell.getClassName()
    private let errorCell = ErrorTableViewCell.getClassName()
    private let inviteCell = InviteTableViewCell.getClassName()
    
    private var isShowTop = true
    private var currentPage = 0
    private var limit = 10
    private var displays: [DisplayModel] = []
    private var topRankCoins: [GetCoinsModel.Coins] = []
    
    private var currentSearchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupRX()
        callApiGetCoins()
    }
    
    func setupView() {
        searchView.layer.cornerRadius = 8
        searchView.backgroundColor = UIColor("#EEEEEE")
        textField.placeholder = "Search"
        
        var nib = UINib(nibName: normalCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: normalCell)
        nib = UINib(nibName: errorCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: errorCell)
        nib = UINib(nibName: inviteCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: inviteCell)
        nib = UINib(nibName: topRankCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: topRankCell)
        tableView.delegate = self
        tableView.dataSource = self
        
        topRefreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        tableView.addSubview(topRefreshControl)
        
        tableView.addInfiniteScroll { [weak self] _ -> Void in
            guard let self = self else { return}
            self.currentPage += self.limit
            self.callApiGetCoins()
        }
    }

    func setupRX() {
        textField.rx.controlEvent([.editingChanged])
            .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
            .asObservable().subscribe{ [weak self] _ in
                guard let self = self else { return }
                guard let value = self.textField.text else { return }
                self.tableView.setContentOffset(.zero, animated: false)
                
                if value.isEmpty {
                    self.isShowTop = true
                    self.tableView.addSubview(self.topRefreshControl)
                } else {
                    self.isShowTop = false
                    self.topRefreshControl.removeFromSuperview()
                }
                
                self.currentPage = 0
                self.currentSearchText = value
                self.callApiGetCoins()
            }.disposed(by: disposeBag)
        
        textFieldClearButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.tableView.setContentOffset(.zero, animated: false)
                self.isShowTop = true
                self.currentPage = 0
                self.currentSearchText = nil
                self.textField.text = nil
                self.tableView.addSubview(self.topRefreshControl)
                self.callApiGetCoins()
            }.disposed(by: disposeBag)
    }
    
    func callApiGetCoinsSuccess(coins: [GetCoinsModel.Coins]) {
        if currentPage == 0 {
            displays = []
            topRankCoins = []
        }
                
        let compactMap = coins.compactMap({ DisplayModel(.normal($0)) })
        displays = displays.filter({ $0.viewType != .invite && $0.viewType != .error })
        displays.append(contentsOf: compactMap)
        
        if isShowTop, topRankCoins.count == 0 {
            topRankCoins.append(coins[0])
            topRankCoins.append(coins[1])
            topRankCoins.append(coins[2])
            displays.removeFirst()
            displays.removeFirst()
            displays.removeFirst()
        }
        
        var next = 5
        for i in 1...displays.count {
            if i == next {
                next *= 2
                displays.insert(.init(.invite), at: i - 1)
            }

            if next > displays.count {
                break
            }
        }
        
        topRefreshControl.endRefreshing()
        tableView.finishInfiniteScroll()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func callApiGetCoinsFailed() {
        if currentPage == 0 {
            displays = []
        }
        
        if currentSearchText != nil {
            tableView.isHidden = true
        } else {
            if !displays.contains(where: { $0.viewType == .error }) {
                displays.append(.init(.error))
            }
        }
        
        topRefreshControl.endRefreshing()
        tableView.finishInfiniteScroll()
        tableView.reloadData()
    }
    
    func callApiGetCoinDetailSuccess(coin: GetCoinModel.Coin) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: CoinDetailVC.getClassName()) as? CoinDetailVC else { return }
        vc.coin = coin
        present(vc, animated: true, completion: nil)
    }
    
    func callApiGetCoinDetailFailed() {
        let dialogMessage = UIAlertController(title: "Error", message: "not found coin", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        present(dialogMessage, animated: true, completion: nil)
    }
    
    func openExternalWeb() {
        guard let url = URL(string: "https://careers.lmwn.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func pullToRefresh(_ sender: AnyObject) {
        if currentSearchText != nil {
            topRefreshControl.endRefreshing()
        } else {
            isShowTop = true
            currentPage = 0
            currentSearchText = nil
            callApiGetCoins()
        }
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if topRankCoins.count > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowTop, topRankCoins.count > 0, section == 0 {
            return 1
        } else {
            return displays.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isShowTop, section == 0 {
            return "Top 3 rank crypto"
        } else {
            return "Buy, sell and hold crypto"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowTop, topRankCoins.count > 0, indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: topRankCell, for: indexPath) as? TopRankTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(topRankCoins)
            cell.callClickItem = { [unowned self] uuid in
                self.callApiGetCoinDetail(uuid: uuid)
            }
            return cell
        } else {
            switch displays[indexPath.row].viewType {
            case .normal(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: normalCell, for: indexPath) as? NormalTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.setupCell(model)
                return cell
            case .invite:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: inviteCell, for: indexPath) as? InviteTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            case .error:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: errorCell, for: indexPath) as? ErrorTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if isShowTop {
                return UITableView.automaticDimension
            }
            return 82
        } else {
            return 82
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch displays[indexPath.row].viewType {
        case .normal(let model):
            guard let uuid = model.uuid else { return }
            callApiGetCoinDetail(uuid: uuid)
        case .invite:
            openExternalWeb()
        case .error:
            callApiGetCoins()
        }
    }
}

extension MainVC {
    func callApiGetCoins() {
        var url = "https://api.coinranking.com/v2/coins?limit=\(limit)&offset=\(currentPage)"
        if let value = currentSearchText {
            url += "&search=\(value)"
        }
        
        AF.request(url).responseDecodable(of: GetCoinsModel.self) { [weak self] response in
            switch response.result {
            case .success(let model):
                if let coins = model.data?.coins, coins.count > 0 {
                    self?.callApiGetCoinsSuccess(coins: coins)
                } else {
                    self?.callApiGetCoinsFailed()
                }
            case .failure:
                self?.callApiGetCoinsFailed()
            }
        }
    }
    
    func callApiGetCoinDetail(uuid: String) {
        let url = "https://api.coinranking.com/v2/coin/\(uuid)"
        AF.request(url).responseDecodable(of: GetCoinModel.self) { [weak self] response in
            switch response.result {
            case .success(let model):
                if let coin = model.data?.coin {
                    self?.callApiGetCoinDetailSuccess(coin: coin)
                } else {
                    self?.callApiGetCoinDetailFailed()
                }
            case .failure:
                self?.callApiGetCoinDetailFailed()
            }
        }
    }
}

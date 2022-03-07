import UIKit
import RxSwift
import Alamofire

class CoinDetailVC: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var openWebButton: UIButton!
    
    static func getClassName() -> String {
        return "\(Self.self)"
    }
    
    private let disposeBag = DisposeBag()
    
    var coin: GetCoinModel.Coin?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupRX()
    }
    
    func setupView() {
        nameLabel.text = coin?.name ?? ""
        symbolLabel.text = "(\(coin?.symbol ?? ""))"
        priceLabel.text = ""
        marketCapLabel.text = ""
        
        if let price = coin?.price {
            priceLabel.text = "$ \(price.to2Decimal)"
        }
        
        if let marketCap = coin?.marketCap {
            marketCapLabel.text = "$ \(marketCap.to2DecimalUnit)"
        }
        
        if let description = coin?.description {
            textView.attributedText = description.htmlToAttributedString
        } else {
            textView.text = "No description"
        }
        
        if let color = coin?.color {
            nameLabel.textColor = UIColor(color)
        }
        
        if coin?.websiteUrl == nil {
            openWebButton.isHidden = true
        }
        
        if let rawUrl = coin?.iconUrl,
           let url = URL(string: rawUrl.replacingOccurrences(of: ".svg", with: ".png")) {
            iconImageView.kf.setImage(with: url)
        }
    }

    func setupRX() {
        closeButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        openWebButton.rx.tap
            .bind { [weak self] in
                self?.openExternalWeb()
            }.disposed(by: disposeBag)
    }
    
    func openExternalWeb() {
        guard let rawUrl = coin?.websiteUrl, let url = URL(string: rawUrl) else { return }
        UIApplication.shared.open(url)
    }
}

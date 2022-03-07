import UIKit
import RxSwift
import RxGesture

class TopRankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    @IBOutlet weak var containerView2: UIView!
    @IBOutlet weak var iconImageView2: UIImageView!
    @IBOutlet weak var symbolLabel2: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var changeLabel2: UILabel!
    
    @IBOutlet weak var containerView3: UIView!
    @IBOutlet weak var iconImageView3: UIImageView!
    @IBOutlet weak var symbolLabel3: UILabel!
    @IBOutlet weak var nameLabel3: UILabel!
    @IBOutlet weak var changeLabel3: UILabel!
    
    static func getClassName() -> String {
        return "\(Self.self)"
    }
    
    private let disposeBag = DisposeBag()
    
    var callClickItem: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor("#F9F9F9").cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .init(width: 0, height: 2)
        containerView.layer.shadowRadius = 2
        containerView.backgroundColor = UIColor("#F9F9F9")
        
        containerView2.layer.cornerRadius = 8
        containerView2.layer.shadowColor = UIColor("#F9F9F9").cgColor
        containerView2.layer.shadowOpacity = 1
        containerView2.layer.shadowOffset = .init(width: 0, height: 2)
        containerView2.layer.shadowRadius = 2
        containerView2.backgroundColor = UIColor("#F9F9F9")
        
        containerView3.layer.cornerRadius = 8
        containerView3.layer.shadowColor = UIColor("#F9F9F9").cgColor
        containerView3.layer.shadowOpacity = 1
        containerView3.layer.shadowOffset = .init(width: 0, height: 2)
        containerView3.layer.shadowRadius = 2
        containerView3.backgroundColor = UIColor("#F9F9F9")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ model: [GetCoinsModel.Coins]) {
        let nameLabel = [nameLabel, nameLabel2, nameLabel3]
        let symbolLabel = [symbolLabel, symbolLabel2, symbolLabel3]
        let changeLabel = [changeLabel, changeLabel2, changeLabel3]
        let iconImageView = [iconImageView, iconImageView2, iconImageView3]
        let containerView = [containerView, containerView2, containerView3]
        
        for i in 0...model.count - 1 {
            nameLabel[i]?.text = model[i].name ?? ""
            symbolLabel[i]?.text = model[i].symbol ?? ""
            changeLabel[i]?.text = ""
            
            if let changeString = model[i].change, let changeDouble = Double(changeString) {
                if changeDouble > 0 {
                    changeLabel[i]?.text = "+\(changeString)"
                    changeLabel[i]?.textColor = .green
                } else {
                    changeLabel[i]?.text = "\(changeString)"
                    changeLabel[i]?.textColor = .red
                }
            }
            
            if let rawUrl = model[i].iconUrl,
               let url = URL(string: rawUrl.replacingOccurrences(of: ".svg", with: ".png")) {
                iconImageView[i]?.kf.setImage(with: url)
            }
            
            guard let uuid = model[i].uuid else { return }
            containerView[i]?.rx
              .anyGesture(.tap())
              .when(.recognized)
              .subscribe(onNext: { [weak self] _ in
                  self?.callClickItem?(uuid)
              })
              .disposed(by: disposeBag)
        }
    }
}

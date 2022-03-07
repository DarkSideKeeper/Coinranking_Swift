
import UIKit
import Kingfisher

class NormalTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    static func getClassName() -> String {
        return "\(Self.self)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor("#F9F9F9").cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .init(width: 0, height: 2)
        containerView.layer.shadowRadius = 2
        containerView.backgroundColor = UIColor("#F9F9F9")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ model: GetCoinsModel.Coins) {
        nameLabel.text = model.name ?? ""
        symbolLabel.text = model.symbol ?? ""
        priceLabel.text = ""
        
        if let price = model.price {
            priceLabel.text = "$ \(price.to2Decimal)"
        }
        
        if let changeString = model.change, let changeDouble = Double(changeString) {
            if changeDouble > 0 {
                changeLabel.text = "+\(changeString)"
                changeLabel.textColor = .green
            } else {
                changeLabel.text = "\(changeString)"
                changeLabel.textColor = .red
            }
        } else {
            changeLabel.text = ""
        }
        
        guard let rawUrl = model.iconUrl else { return }
        guard let url = URL(string: rawUrl.replacingOccurrences(of: ".svg", with: ".png")) else { return }
        iconImageView.kf.setImage(with: url)
    }
}

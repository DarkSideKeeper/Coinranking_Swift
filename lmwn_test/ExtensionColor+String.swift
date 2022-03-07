import UIKit

extension UIColor {
    convenience init(_ hexFromString: String, alpha: CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var to2Decimal: String {
        let decimal = self.components(separatedBy: ".")
        guard let first = decimal.first, let last = decimal.last?.prefix(2) else { return self }
        return "\(first).\(last)"
    }
    
    var to2DecimalUnit: String {
        guard let value = Double(self) else { return "\(self)" }
        let number = value
        let million = number / 1000000
        let billion = number / 1000000000
        let trillion = number / 1000000000000
        
        var money = ""
        var unit = ""
        if trillion >= 1.0 {
            money = "\(trillion*10/10)"
            unit = "trillion"
        } else if billion >= 1.0 {
            money = "\(billion*10/10)"
            unit = "billion"
        } else if million >= 1.0 {
            money = "\(million*10/10)"
            unit = "million"
        } else {
            money = "\(number)"
        }
        
        let decimal = money.components(separatedBy: ".")
        guard let first = decimal.first, let last = decimal.last?.prefix(2) else { return "\(self)" }
        guard let value = Double("\(first).\(last)") else { return "\(self)" }
        return "\(value) \(unit)"
        
    }
}

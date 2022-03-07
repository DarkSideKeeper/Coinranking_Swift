struct DisplayModel {
    
    enum DisplayType: Equatable {
        static func == (lhs: DisplayModel.DisplayType, rhs: DisplayModel.DisplayType) -> Bool {
            switch (lhs, rhs) {
            case (.normal, .normal):
                return true
            case (.invite, .invite):
                return true
            case (.error, .error):
                return true
            default:
                return false
            }
        }
        
        case normal(GetCoinsModel.Coins)
        case invite
        case error
    }
    
    var viewType: DisplayType = .error
    
    init(_ viewType: DisplayType) {
        self.viewType = viewType
    }
}

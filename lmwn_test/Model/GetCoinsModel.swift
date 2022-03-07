import Foundation

struct GetCoinsModel: Codable {
    let status : String?
    let data : Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(Data.self, forKey: .data)
    }
    
    struct Stats : Codable {
        let total : Int?
        let totalCoins : Int?
        let totalMarkets : Int?
        let totalExchanges : Int?
        let totalMarketCap : String?
        let total24hVolume : String?

        enum CodingKeys: String, CodingKey {

            case total = "total"
            case totalCoins = "totalCoins"
            case totalMarkets = "totalMarkets"
            case totalExchanges = "totalExchanges"
            case totalMarketCap = "totalMarketCap"
            case total24hVolume = "total24hVolume"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            total = try values.decodeIfPresent(Int.self, forKey: .total)
            totalCoins = try values.decodeIfPresent(Int.self, forKey: .totalCoins)
            totalMarkets = try values.decodeIfPresent(Int.self, forKey: .totalMarkets)
            totalExchanges = try values.decodeIfPresent(Int.self, forKey: .totalExchanges)
            totalMarketCap = try values.decodeIfPresent(String.self, forKey: .totalMarketCap)
            total24hVolume = try values.decodeIfPresent(String.self, forKey: .total24hVolume)
        }

    }


    struct Data : Codable {
        let stats : Stats?
        let coins : [Coins]?

        enum CodingKeys: String, CodingKey {

            case stats = "stats"
            case coins = "coins"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            stats = try values.decodeIfPresent(Stats.self, forKey: .stats)
            coins = try values.decodeIfPresent([Coins].self, forKey: .coins)
        }

    }

    struct Coins : Codable {
        let uuid : String?
        let symbol : String?
        let name : String?
        let color : String?
        let iconUrl : String?
        let marketCap : String?
        let price : String?
        let listedAt : Int?
        let tier : Int?
        let change : String?
        let rank : Int?
        let lowVolume : Bool?
        let coinrankingUrl : String?
        let _24hVolume : String?
        let btcPrice : String?

        enum CodingKeys: String, CodingKey {

            case uuid = "uuid"
            case symbol = "symbol"
            case name = "name"
            case color = "color"
            case iconUrl = "iconUrl"
            case marketCap = "marketCap"
            case price = "price"
            case listedAt = "listedAt"
            case tier = "tier"
            case change = "change"
            case rank = "rank"
            case lowVolume = "lowVolume"
            case coinrankingUrl = "coinrankingUrl"
            case _24hVolume = "24hVolume"
            case btcPrice = "btcPrice"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
            symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            color = try values.decodeIfPresent(String.self, forKey: .color)
            iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
            marketCap = try values.decodeIfPresent(String.self, forKey: .marketCap)
            price = try values.decodeIfPresent(String.self, forKey: .price)
            listedAt = try values.decodeIfPresent(Int.self, forKey: .listedAt)
            tier = try values.decodeIfPresent(Int.self, forKey: .tier)
            change = try values.decodeIfPresent(String.self, forKey: .change)
            rank = try values.decodeIfPresent(Int.self, forKey: .rank)
            lowVolume = try values.decodeIfPresent(Bool.self, forKey: .lowVolume)
            coinrankingUrl = try values.decodeIfPresent(String.self, forKey: .coinrankingUrl)
            _24hVolume = try values.decodeIfPresent(String.self, forKey: ._24hVolume)
            btcPrice = try values.decodeIfPresent(String.self, forKey: .btcPrice)
        }

    }

}

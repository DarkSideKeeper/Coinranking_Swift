/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct GetCoinModel : Codable {
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
    
    struct Data : Codable {
        let coin : Coin?

        enum CodingKeys: String, CodingKey {

            case coin = "coin"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            coin = try values.decodeIfPresent(Coin.self, forKey: .coin)
        }

    }
    
    struct Coin : Codable {
        let uuid : String?
        let symbol : String?
        let name : String?
        let description : String?
        let color : String?
        let iconUrl : String?
        let websiteUrl : String?
        let links : [Links]?
        let supply : Supply?
        let numberOfMarkets : Int?
        let numberOfExchanges : Int?
        let _24hVolume : String?
        let marketCap : String?
        let price : String?
        let btcPrice : String?
        let priceAt : Int?
        let change : String?
        let rank : Int?
        let allTimeHigh : AllTimeHigh?
        let coinrankingUrl : String?
        let tier : Int?
        let lowVolume : Bool?
        let listedAt : Int?

        enum CodingKeys: String, CodingKey {

            case uuid = "uuid"
            case symbol = "symbol"
            case name = "name"
            case description = "description"
            case color = "color"
            case iconUrl = "iconUrl"
            case websiteUrl = "websiteUrl"
            case links = "links"
            case supply = "supply"
            case numberOfMarkets = "numberOfMarkets"
            case numberOfExchanges = "numberOfExchanges"
            case _24hVolume = "24hVolume"
            case marketCap = "marketCap"
            case price = "price"
            case btcPrice = "btcPrice"
            case priceAt = "priceAt"
            case change = "change"
            case rank = "rank"
            case allTimeHigh = "allTimeHigh"
            case coinrankingUrl = "coinrankingUrl"
            case tier = "tier"
            case lowVolume = "lowVolume"
            case listedAt = "listedAt"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
            symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            description = try values.decodeIfPresent(String.self, forKey: .description)
            color = try values.decodeIfPresent(String.self, forKey: .color)
            iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
            websiteUrl = try values.decodeIfPresent(String.self, forKey: .websiteUrl)
            links = try values.decodeIfPresent([Links].self, forKey: .links)
            supply = try values.decodeIfPresent(Supply.self, forKey: .supply)
            numberOfMarkets = try values.decodeIfPresent(Int.self, forKey: .numberOfMarkets)
            numberOfExchanges = try values.decodeIfPresent(Int.self, forKey: .numberOfExchanges)
            _24hVolume = try values.decodeIfPresent(String.self, forKey: ._24hVolume)
            marketCap = try values.decodeIfPresent(String.self, forKey: .marketCap)
            price = try values.decodeIfPresent(String.self, forKey: .price)
            btcPrice = try values.decodeIfPresent(String.self, forKey: .btcPrice)
            priceAt = try values.decodeIfPresent(Int.self, forKey: .priceAt)
            change = try values.decodeIfPresent(String.self, forKey: .change)
            rank = try values.decodeIfPresent(Int.self, forKey: .rank)
            allTimeHigh = try values.decodeIfPresent(AllTimeHigh.self, forKey: .allTimeHigh)
            coinrankingUrl = try values.decodeIfPresent(String.self, forKey: .coinrankingUrl)
            tier = try values.decodeIfPresent(Int.self, forKey: .tier)
            lowVolume = try values.decodeIfPresent(Bool.self, forKey: .lowVolume)
            listedAt = try values.decodeIfPresent(Int.self, forKey: .listedAt)
        }

    }
    
    struct AllTimeHigh : Codable {
        let price : String?
        let timestamp : Int?

        enum CodingKeys: String, CodingKey {

            case price = "price"
            case timestamp = "timestamp"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            price = try values.decodeIfPresent(String.self, forKey: .price)
            timestamp = try values.decodeIfPresent(Int.self, forKey: .timestamp)
        }

    }
    
    struct Links : Codable {
        let name : String?
        let type : String?
        let url : String?

        enum CodingKeys: String, CodingKey {

            case name = "name"
            case type = "type"
            case url = "url"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            url = try values.decodeIfPresent(String.self, forKey: .url)
        }

    }
    
    struct Supply : Codable {
        let confirmed : Bool?
        let total : String?
        let circulating : String?

        enum CodingKeys: String, CodingKey {

            case confirmed = "confirmed"
            case total = "total"
            case circulating = "circulating"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            confirmed = try values.decodeIfPresent(Bool.self, forKey: .confirmed)
            total = try values.decodeIfPresent(String.self, forKey: .total)
            circulating = try values.decodeIfPresent(String.self, forKey: .circulating)
        }

    }


}

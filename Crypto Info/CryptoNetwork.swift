//
//  CryptoNetwork.swift
//  Crypto Info
//
//  Created by Jaskirat Singh on 05/04/18.
//  Copyright © 2018 jassie. All rights reserved.
//

import Foundation

struct CryptoNetwork
{
    mutating func obtainData(completion: @escaping(_ error: String?, _ data: [String]?, _ price: [String]?, _ symbol: [String]?, _ change24H: [String]?, _ change7Day: [String]?, _ change1H: [String]?, _ ranking: [String]?)-> ())
    {
        var cryptoName: [String] = []
        var crypName: [String] = []
        var priceUSD: [String] = []
        var symb: [String] = []
        var rank: [String] = []
        var change1H: [String] = []
        var change7Day: [String] = []
        var change1Day: [String] = []
        
        let url = URL(string: "https://api.coinmarketcap.com/v1/ticker/")!
        let session = URLSession.shared
        let task = session.dataTask(with: url){ data, response, error in
            if error != nil
            {
                completion(error?.localizedDescription,nil,nil,nil,nil,nil,nil,nil)
                return
            }
            
            let parseData = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
            
            for names in parseData
            {
                if let name = names["name"] as? String
                {
                    cryptoName.append(name)
                }
            }
            for amount in parseData
            {
                if let dollars = amount["price_usd"] as? String
                {
                    priceUSD.append(dollars)
                }
            }
            for symbl in parseData
            {
                if let symbol = symbl["symbol"] as? String
                {
                    symb.append(symbol)
                }
            }
            for change in parseData
            {
                if let chng = change["percent_change_24h"] as? String
                {
                    change1Day.append(chng)
                }
            }
            for  ranking in parseData
            {
                if let rak = ranking["rank"] as? String
                {
                    rank.append(rak)
                }
            }
            for chang1H in parseData
            {
                if let chg1H = chang1H["percent_change_1h"] as? String
                {
                    change1H.append(chg1H)
                }
            }
            for change1Week in parseData
            {
                if let chg1W = change1Week["percent_change_7d"] as? String
                {
                    change7Day.append(chg1W)
                }
            }
            
            crypName = cryptoName
            completion(nil, crypName, priceUSD, symb, change1Day, rank, change1H, change7Day)
            
        }
        task.resume()
    }
}

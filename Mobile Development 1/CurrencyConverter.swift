//
//  CurrencyConverter.swift
//  Mobile Development 1
//
//  Created by Александр on 2/29/16.
//
//

import Foundation
import Alamofire
import SWXMLHash

class CurrencyConverter {
    
    var currencies = [Currency]()
    
    init() {
        Alamofire.request(.GET, "https://nbrb.by/Services/XmlExRates.aspx").responseString { responseString in
            
            let resultString = responseString.result.value!
            let data = SWXMLHash.parse(resultString)
            do {
                let r = try data.byKey("DailyExRates")
                let r2 = try data.byKey("Currency")
            }
            catch {
                return
            }
            let root = data["Currency"]
            let currencyIndexer = root["Currency"]
            let currencyElems = currencyIndexer.all
            //let currencyElems = SWXMLHash.parse(responseString.result.value!)["DailyExRates"]["Currency"].all
            
            for currencyElem in currencyElems {
                let name = String(currencyElem["Name"])
                let code = String(currencyElem["CharCode"])
                
                guard let rate = Double(String(currencyElem["Rate"])) else {
                    break
                }
                guard let scale = Double(String(currencyElem["Scale"])) else {
                    break
                }
                
                self.currencies.append(Currency(name: name, code: code, rate: rate / scale))
            }
            
            let a = 3
        }
    }
    
}

class Currency {
    
    init(name: String, code: String, rate: Double) {
        self.name = name
        self.code = code
        self.rate = rate
    }
    
    var name: String
    var code: String
    var rate: Double
    
}
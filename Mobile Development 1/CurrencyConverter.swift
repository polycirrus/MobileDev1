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
            
            guard responseString.result.isSuccess else {
                return
            }
            
            guard let data = responseString.data else {
                return
            }
            
            let xmlElems = SWXMLHash.parse(data)
            let currencyElems = xmlElems["DailyExRates"].children
            
            for currencyElem in currencyElems {
                
                guard let name = currencyElem["Name"].element?.text else {
                    continue
                }
                guard let code = currencyElem["CharCode"].element?.text else {
                    continue
                }
                
                guard let rateString = currencyElem["Rate"].element?.text else {
                    continue
                }
                guard let rate = Double(rateString) else {
                    continue
                }
                
                guard let scaleString = currencyElem["Scale"].element?.text else {
                    continue
                }
                guard let scale = Double(scaleString) else {
                    continue
                }
                
                self.currencies.append(Currency(name: name, code: code, rate: rate / scale))
                
            }
            
        }
    }
    
    func ConvertTo(value: Double, currency: Currency) -> Double {
        return value / currency.rate
    }
    
    func ConvertFrom(value: Double, currency: Currency) -> Double {
        return value * currency.rate
    }
    
    func Convert(value: Double, from sourceCurrency: Currency, to destCurrency: Currency) -> Double {
        return value * sourceCurrency.rate / destCurrency.rate
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
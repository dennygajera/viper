//
//  NSDictionaryExt.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import Foundation
import UIKit
extension NSDictionary {
    /// decoding json value and convert it into data
    func dataReturn() -> Data {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.value(forKey: "data") as Any, options: .prettyPrinted)
            
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            guard let data = reqJSONStr?.data(using: .utf8) else { return Data() }
            return data
        } catch let err {
            print("Error while converting data", err.localizedDescription)
            return Data()
        }
    }
}

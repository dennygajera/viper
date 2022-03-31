//
//  MockAPI.swift
//  ViPERTests
//
//  Created by Darshan Gajera on 30/03/22.
//

import XCTest
@testable import ViPER

class MockNetworkRequestManager: WebServiceHandlerProtocol {
    
    enum ResponseType {
        case error
        case success
    }
    
    var responseType: ResponseType = .error
    
    func getWebService(wsMethod: RequestBuilder.APISection, complete: @escaping ([String : Any]?) -> Void) {
        switch responseType {
        case .error:
            complete(nil)
        case .success:
            let t = type(of: self)
            let bundle = Bundle(for: t.self)
            let path = bundle.url(forResource: "sampleResponse", withExtension: "json")!
            let data = try! Data(contentsOf: path)
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            complete(["data": json])
        }
    }
}

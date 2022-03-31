//
//  RequestBuilder.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//

import Foundation

class RequestBuilder {
    
    enum APISection: String {
        case all
    }
    
    static func getContest(for section: APISection) -> URL? {
        
        var urlComponents = URLComponents()
        //"https://kontests.net/api/v1/"
        urlComponents.scheme = "https"
        urlComponents.host = "kontests.net"
        urlComponents.path = "/api/v1/\(section.rawValue)"
        
        urlComponents.queryItems = [URLQueryItem(name: "api-key", value: "sGecvmIXM2UIIH8QoGslprpSbAvWTqNi")]
        
        return urlComponents.url
    }
}

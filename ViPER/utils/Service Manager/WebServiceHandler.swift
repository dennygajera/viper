//
//  WebServiceHandler.swift
//  ViPER
//
//  Created by Darshan Gajera on 30/03/22.
//


import Foundation

protocol WebServiceHandlerProtocol {
    func getWebService(wsMethod: RequestBuilder.APISection, complete:@escaping (_ response: [String:Any]?) -> Void)
}

class WebServiceHandler: WebServiceHandlerProtocol {

    static let shared = WebServiceHandler()
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?

    func getWebService(wsMethod: RequestBuilder.APISection, complete:@escaping (_ response: [String:Any]?) -> Void) {
    
        guard let url = RequestBuilder.getContest(for: wsMethod) else { return }
        
        dataTask?.cancel()

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            
            defer { self?.dataTask = nil }

            guard error == nil else {
                complete(nil)
                return
            }
            
            guard let data = data else {
                complete(nil)
                return
            }
            
            if let response = response as?
                HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        complete(["data": json])
                    } catch {
                        print(error)
                        complete(nil)
                    }
                    break
                default:
                    print("Err Status Code: \(response.statusCode)")
                    complete(nil)
                }
            }
        }
        dataTask?.resume()
    }
}


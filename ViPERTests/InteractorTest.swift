//
//  InteractorTest.swift
//  ViPERTests
//
//  Created by Darshan Gajera on 30/03/22.
//

import XCTest
@testable import ViPER

class InteractorTest: XCTestCase {

    var InteractorTest: DashboardInteractor!
    var mockRequestManager: MockNetworkRequestManager!
    
    override func setUpWithError() throws {
        InteractorTest = DashboardInteractor()
        mockRequestManager = MockNetworkRequestManager()
        prepareMockData()
    }
    
    override func tearDownWithError() throws {
        InteractorTest = nil
        mockRequestManager = nil
    }

    func prepareMockData() {
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        let path = bundle.url(forResource: "sampleResponse", withExtension: "json")!
        let data = try! Data(contentsOf: path)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        do {
            _ = try JSONDecoder().decode([ContestModel].self, from: ((["data": json] as! NSDictionary).dataReturn()))
        } catch let err {
            print("Error while converting data into model", err.localizedDescription)
        }
    }
    
    func testFetchContestApi() throws {
        mockRequestManager.getWebService(wsMethod: .all) {data in
            XCTAssertTrue(data == nil)
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

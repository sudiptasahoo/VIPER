//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Sudipta Sahoo on 10/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingTests: XCTestCase {

    var network: Networking!
    
    override func setUp() {
        network = Networking.shared
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfValidEndPointReturnsNonNilResponse() {
        
        let expect = expectation(description: "This Expectation will expect the end of Network call until the closure is executed")
        
        XCTAssertNotNil(network.request(TestEndPoint.validEndPoint) { (result: Result<[Contact], Error>) in
            switch result{
            case .success(let decodedObj):
                XCTAssertNotNil(decodedObj)
            case .failure(let error):
                XCTAssertNil(error)
            }
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 60) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  dolap_ios_case_studyTests.swift
//  dolap-ios-case-studyTests
//
//  Created by Emre Çelik on 4.11.2020.
//

import XCTest
@testable import dolap_ios_case_study

// Clean-Swift/TDD için unit test yapılabilir. (WorkerSpy, WorkerTests vs.)
class dolap_ios_case_studyTests: XCTestCase {

    func testProductDecoding() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "product", withExtension: "json") else {
            XCTFail("Missing file: product.json"); return
        }
        
        let jsonData = try Data(contentsOf: url)

        XCTAssertNoThrow(try JSONDecoder().decode(Product.self, from: jsonData))
    }
    
    func testSocialDecoding() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "social", withExtension: "json") else {
            XCTFail("Missing file: social.json"); return
        }
        
        let jsonData = try Data(contentsOf: url)

        XCTAssertNoThrow(try JSONDecoder().decode(Social.self, from: jsonData))
    }

}

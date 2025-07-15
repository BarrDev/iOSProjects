//
//  TestingTests.swift
//  TestingTests
//
//  Created by Joe L Barr on 3/10/24.
//

import XCTest
@testable import Testing

final class TestingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSum() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "data", withExtension: "json") else {
            XCTFail("Missing file: data.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        let movie = try decoder.decode(Movie.self, from: json)
        
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie.name, "Titanic")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let date = dateFormatter.date(from:"12/19/1997")
        XCTAssertEqual(movie.releaseDate, date)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

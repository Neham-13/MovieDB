//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by Neha2 Mishra on 09/05/22.
//

import XCTest
import MovieDB
@testable import MovieDB

class MovieDBUITests: XCTestCase {
    
    var uiForTest: MovieVC!
        
        override func setUp() {
            
            super.setUp()
            
            //get the storyboard the ViewController under test is inside
            let storyboard: UIStoryboard = UIStoryboard(name: "MovieVC", bundle: nil)
            
            //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
            uiForTest = storyboard.instantiateViewController(withIdentifier: "MovieVC") as? MovieVC
            
            //load view hierarchy
            _ = uiForTest.view
        }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSUT_CollectionViewIsNotNilAfterViewDidLoad() {
            
            XCTAssertNotNil(uiForTest.collectionVW)
        }
   
        func testSUT_ShouldSetCollectionViewDataSource() {
            
            XCTAssertNotNil(uiForTest.collectionVW.dataSource)
        }
        
        func testSUT_ShouldSetCollectionViewDelegate() {
            
            XCTAssertNotNil(uiForTest.collectionVW.delegate)
        }
}

//
//  ImageSearchTests.swift
//  ImageSearchTests
//
//  Created by Gio Lomsa on 9/19/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import XCTest
@testable import ImageSearch

class ImageSearchTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSearchResult(){
        
        let expectation = XCTestExpectation(description: "Search for cars ")
        let networking = HTTPLayer()
        
        networking.request(at: .search("Cars", 43), isImage: false) { (data, response, error) in
            
            XCTAssertNotNil(data, "Loading search results failed")
            if let response = response as? HTTPURLResponse{
                XCTAssert(response.statusCode.isSuccessHTTPCode, "Search results response status code wasn't success")
            }else{
                XCTAssert(false, "Search response error")
            }
            XCTAssertNil(error, "Search error")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testImageLoadingUrlSession(){
        
        let expectation = XCTestExpectation(description: "Download image from Url")
        
        let imageUrlString = "https://pixabay.com/get/52e4dd43435baa14f6da8c7dda79367d1337d8ec53566c48702973dd9244c05cbe_1280.jpg"
        let networking = HTTPLayer()
        networking.request(at: .downloadFromUrl(imageUrlString), isImage: true) { (data, response, error) in
            
            XCTAssertNotNil(data, "Image download failed")
            
            if let response = response as? HTTPURLResponse{
                XCTAssert(response.statusCode.isSuccessHTTPCode, "Image download response status wasn't success")
            }else{
                XCTAssert(false, "Image download response failed")
            }
            
            XCTAssertNil(error, "Image download error")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testImageLoadingMethod(){
        let viewModel = SearchResultViewModel()
        let imageUrlString = "https://pixabay.com/get/52e4dd43435baa14f6da8c7dda79367d1337d8ec53566c48702973dd9244c05cbe_1280.jpg"
        
        let expectation = XCTestExpectation(description: "Download image from Url in viewModel")
        
        viewModel.loadImageFromUrl(urlString: imageUrlString) { (imageData) in
            XCTAssertNotNil(imageData, "Error loading image")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPrimeNumberExtension(){
        let primeNumber = 43
        let nonPrimeNumber = 44
        
        XCTAssert(primeNumber.isPrimeNumber, "Prime number extension failes")
        XCTAssert(!nonPrimeNumber.isPrimeNumber, "Prime number extension failes")
        
    }
    
}

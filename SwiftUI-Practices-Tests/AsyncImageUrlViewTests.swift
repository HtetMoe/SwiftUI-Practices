//
//  AsyncImageUrlViewTests.swift
//  MyCodesTests
//
//  Created by Htet Moe Phyu on 26/07/2023.
//
import XCTest

//This is test for async code
final class AsyncImageUrlViewTests: XCTestCase {
    
    func testPhotoDownload_and_ImageOrientationIsIdentical() {
        let urlString = "https://media.licdn.com/dms/image/D4D03AQEG95jXAuhqeQ/profile-displayphoto-shrink_800_800/0/1690207995167?e=1695859200&v=beta&t=CZOd6MLdyPamOYD78X2uuV3W3mCTRwM_LMMg7uZiEUw"
        
        guard let url = URL(string: urlString) else {
            XCTFail("Invalid URL")
            return
        }
        
        let sessionAnsweredExpectation = expectation(description: "Session")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                XCTFail(error.localizedDescription)
                sessionAnsweredExpectation.fulfill()
            }
            else if let data = data, let image = UIImage(data: data) {
                let expectedImgOrientation = UIImage(named: "Example")?.imageOrientation
                XCTAssertEqual(image.imageOrientation, expectedImgOrientation)
                
                // Fulfill the expectation when the image download is successful
                sessionAnsweredExpectation.fulfill()
            } else {
                XCTFail("Failed to download image.")
                sessionAnsweredExpectation.fulfill()
            }
        }.resume()
        waitForExpectations(timeout: 8)
    }
    
}

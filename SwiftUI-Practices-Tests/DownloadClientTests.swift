//
//  DownloadClientTests.swift
//  MyCodesTests
//
//  Created by Htet Moe Phyu on 26/07/2023.
//

import XCTest
import Foundation

//This is test for end point and mock data
final class DownloadClientTests: XCTestCase {
    var sut : DownloadClient!
    var mockURLSession : MockURLSession!
    
    override func setUp() {
        super.setUp()
        sut = DownloadClient()
        mockURLSession = MockURLSession()
        sut.session    = mockURLSession
    }
    
    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    let urlString = "https://media.licdn.com/dms/image/D4D03AQEG95jXAuhqeQ/profile-displayphoto-shrink_800_800/0/1690207995167?e=1695859200&v=beta&t=CZOd6MLdyPamOYD78X2uuV3W3mCTRwM_LMMg7uZiEUw"
    
    //check for base url
    func testDownload_UsedExceptedHost(){
        sut.downloadImage(withURL: urlString)
        guard let url = URL(string: urlString) else { XCTFail("Invalid URL!");return }
        let urlComponents = URLComponents(url: url , resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "media.licdn.com")
    }
    
    //check for path
    func testDownload_UsedExceptedPaht(){
        sut.downloadImage(withURL: urlString)
        guard let url = URL(string: "https://media.licdn.com/dms/image") else { XCTFail("Invalid URL!"); return }
        let urlComponents = URLComponents(url: url , resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.path, "/dms/image")
    }
    
    //test terrible fun performance, major performance issue 
    func testTerribleFunction_Performance(){
        measure { // measure the performance of a block of code
            sut.terribleFunctionYouWouldNeverWrite()
        }
    }
}

//mock
extension DownloadClientTests {
    class MockURLSession : SessionProtocol {
        var url : URL?
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}

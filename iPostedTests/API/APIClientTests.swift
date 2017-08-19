//
//  APIClientTests.swift
//  iPostedTests
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ApiClient_Uses_Proper_EndPoint() {
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let completion = { (users: [User]?, error: Error?) in }
        
        sut.loadUsers(completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        XCTAssertEqual(urlComponents?.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(urlComponents?.path, "/users")
        
    }
    
    func test_LoadUsers_WhenSuccessfull_Returns_Users() {
        
        guard let jsonData = JSONMockLoader.loadJSONData(file: "users_array", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        
        sut.session = mockURLSession
        
        let usersExpectation = expectation(description: "Users")
        
        var users: [User]? = nil
        
        sut.loadUsers { (usersFetched, error) in
            users = usersFetched
            usersExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(users?.count, 2)
        }
    }
    
}

extension APIClientTests {
    
    class MockURLSession: SessionProtocol {
        var url: URL?
        private let dataTask: MockTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data, urlResponse: urlResponse, error: error)
        }
        
        func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            dataTask.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
}

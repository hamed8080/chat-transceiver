//
// DownloadManagerTests.swift
// Copyright (c) 2022 ChatTransceiver
//
// Created by Hamed Hosseini on 11/2/22
//
import Foundation
import XCTest
import Mocks
@testable import ChatTransceiver

@available(iOS 13.0, *)
final class DownloadManagerTests: XCTestCase {

    private var sut: DownloadManager!
    private var mockURLSession: MockURLSession!
    private var exp: XCTestExpectation!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let params = DownloadManagerParameters(forceToDownload: true,
                                               url: URL(string: "www.test.com")!,
                                               token: "",
                                               uniqueId: UUID().uuidString)
        mockURLSession = MockURLSession()
        let delegate = ProgressImplementation(uniqueId: params.uniqueId, downloadProgress: onDownloadProgress, downloadCompletion: onDownloadCompletion)
        mockURLSession.delegate = delegate
        sut = DownloadManager(params: params, urlSession: mockURLSession)
    }

    func test_whenDownloadWithProgressCompletion_progressCompletionIsWorking() {
        exp = expectation(description: "Expected to receive progress value in progress completion.")
        let task = sut.download()
        mockURLSession.data = "TEST".data(using: .utf8)
        wait(for: [exp], timeout: 1)
    }

    func onDownloadCompletion(_ data: Data?, response: URLResponse?, error: Error?) {

    }

    func onDownloadProgress(_ progress: DownloadFileProgress) {
        if progress.percent != 0 {
            exp.fulfill()
        }
    }
}

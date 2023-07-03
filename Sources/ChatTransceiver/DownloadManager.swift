//
// DownloadManager.swift
// Copyright (c) 2022 ChatTransceiver
//
// Created by Hamed Hosseini on 12/14/22

import Additive
import Foundation
import Mocks

public final class DownloadManager {
    public init() {}

    public func download(_ params: DownloadManagerParameters,
                         _ urlSession: URLSessionProtocol? = nil,
                         progress: DownloadProgressType? = nil,
                         completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol? {
        var request = URLRequest(url: params.url)
        params.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        if let parameters = params.params, parameters.count > 0, params.method == .get {
            var urlComp = URLComponents(string: params.url.absoluteString)!
            urlComp.queryItems = []
            parameters.forEach { key, value in
                urlComp.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
            }
            request.url = urlComp.url
        }
        request.method = params.method
        let delegate = ProgressImplementation(uniqueId: params.uniqueId, downloadProgress: progress, downloadCompletion: completion)
        let session = urlSession ?? URLSession(configuration: .default, delegate: delegate, delegateQueue: .main)
        if let mock = urlSession as? MockURLSession {
            mock.delegate = delegate
        }
        let downloadTask = session.dataTask(request)
        downloadTask.resume()
        return downloadTask
    }
}

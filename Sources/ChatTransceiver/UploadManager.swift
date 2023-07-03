//
// UploadManager.swift
// Copyright (c) 2022 ChatTransceiver
//
// Created by Hamed Hosseini on 12/14/22

import Foundation
import Additive
import Mocks

public final class UploadManager {
    public init() {
    }

    public func upload(_ req: UploadManagerParameters, _ data: Data, _ urlSession: URLSessionProtocol? = nil, progress: UploadProgressType? = nil, completion: ((Data?, URLResponse?, Error?) -> Void)? = nil) -> URLSessionDataTaskProtocol? {
        guard let url = URL(string: req.url) else { return nil }
        var request = URLRequest(url: url)
        let boundary = "Boundary-\(UUID().uuidString)"
        let body = multipartFormDatas(req, data, boundary: boundary)
        req.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.method = .post
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let delegate = ProgressImplementation(uniqueId: req.uniqueId, uploadProgress: progress)
        let session = urlSession ?? URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        let uploadTask = session.uploadTask(request, body as Data) { data, response, error in
            DispatchQueue.main.async {
                completion?(data, response, error)
            }
        }
        if let mock = session as? MockURLSession {
            mock.delegate = delegate
        }
        uploadTask.resume()
        return uploadTask
    }

    private func multipartFormDatas(_ req: UploadManagerParameters, _ data: Data, boundary: String) -> NSMutableData {
        let httpBody = NSMutableData()
        req.parameters?.forEach { key, value in
            if let value = value as? String, let data = convertFormField(named: key, value: value, boundary: boundary) {
                httpBody.append(data)
            }
        }

        httpBody.append(convertFileData(fieldName: "file", fileName: req.fileName, mimeType: req.mimeType, fileData: data, boundary: boundary))

        httpBody.append("--\(boundary)--") // close all boundary
        return httpBody
    }

    private func convertFileData(fieldName: String, fileName: String, mimeType: String?, fileData: Data, boundary: String) -> Data {
        let data = NSMutableData()
        let lineBreak = "\r\n"
        let mimeType = mimeType ?? "content-type header"
        data.append("--\(boundary + lineBreak)")
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\(lineBreak)")
        data.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
        data.append(fileData)
        data.append(lineBreak)
        return data as Data
    }

   private func convertFormField(named name: String, value: String, boundary: String) -> Data? {
        let lineBreak = "\r\n"
        var fieldString = "--\(boundary + lineBreak)"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\(lineBreak + lineBreak)"
        fieldString += value + lineBreak
        return fieldString.data(using: .utf8)
    }
}

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

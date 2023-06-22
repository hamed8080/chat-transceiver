//
// DownloadManagerParameters.swift
// Copyright (c) 2022 ChatTransceiver
//
// Created by Hamed Hosseini on 12/14/22

import Additive
import Foundation

public struct DownloadManagerParameters {
    public var forceToDownload: Bool = false
    public let url: URL
    public let token: String
    public var headers: [String: String]? { ["Authorization": "Bearer \(token)"] }
    public var params: [String: Any]?
    public let isImage: Bool
    public let thumbnail: Bool
    public var hashCode: String?
    public var method: HTTPMethod = .get
    public var uniqueId: String

    public init(forceToDownload: Bool = false,
                url: URL,
                token: String,
                params: [String: Any]? = nil,
                thumbnail: Bool = false,
                hashCode: String? = nil,
                isImage: Bool = false,
                method: HTTPMethod = .get,
                uniqueId: String) {
        self.forceToDownload = forceToDownload
        self.url = url
        self.token = token
        self.params = params
        self.isImage = isImage
        self.hashCode = hashCode
        self.method = method
        self.uniqueId = uniqueId
        self.thumbnail = thumbnail
    }
}

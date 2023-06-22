//
// GlobalVariables.swift
// Copyright (c) 2022 ChatTransceiver
//
// Created by Hamed Hosseini on 12/14/22

import Foundation
import ChatDTO
import ChatCore
import ChatModels

public typealias DownloadProgressType = (DownloadFileProgress) -> Void
public typealias UploadFileProgressType = (UploadFileProgress?, ChatError?) -> Void
public typealias UploadCompletionType = (UploadFileResponse?, FileMetaData?, ChatError?) -> Void
public typealias DownloadFileCompletionType = (Data?, URL?, File?, ChatError?) -> Void
public typealias DownloadImageCompletionType = (Data?, URL?, Image?, ChatError?) -> Void

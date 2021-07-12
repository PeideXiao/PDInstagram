//
//  ParameterEncoding.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters:Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL =   "URL is nil."
    case networkUnavailable = "Network is unavailable."
}


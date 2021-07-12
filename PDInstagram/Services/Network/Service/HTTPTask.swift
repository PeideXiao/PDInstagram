//
//  HTTPTask.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters:Parameters?, urlParameters:Parameters?)
    case requestParametersAndHeaders(bodyParameters:Parameters?, urlParameters:Parameters?,additionalHeader:HTTPHeaders?)
    case uploadData(bodyParameters:Parameters?, fileParameters: Parameters?, additionalHeader:HTTPHeaders?)
}

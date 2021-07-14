//
//  EndPointType.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}


//extension EndPointType {
//    var baseURL: URL {
//        guard let baseURL = URL(string: "https://api.themoviedb.org/3/movie/") else {
//            return URL(string: "https://www.google.com")!
//        }
//        return baseURL
//    }
//}

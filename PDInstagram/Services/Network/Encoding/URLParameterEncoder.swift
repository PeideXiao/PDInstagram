//
//  URLParameterEncoder.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed))
                urlComponents.queryItems?.append(queryItem);
            }
            urlRequest.url = urlComponents.url;
        }
        
        if (urlRequest.value(forHTTPHeaderField: "Content-Type") == nil) {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

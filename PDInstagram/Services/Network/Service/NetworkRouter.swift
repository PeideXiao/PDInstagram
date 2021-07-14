//
//  NetworkRouter.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

struct NetworkRouter<T: EndPointType> {
    
    let kBoundary = "alamofire.boundary.2f832832f886c5c1"
    var task: URLSessionTask?
    typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
    
    
   mutating public func request(_ router: T, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: router);
            print("***\(request.url!)")
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error);
            })
            task!.resume();
        } catch {
            completion(nil, nil, error)
        }
    }
    
    
    public func cancel() {
        task?.cancel()
    }
    
    
    // FILEPRIVATE functions
    fileprivate func buildRequest(from route: T) throws -> URLRequest {
        
        var request = URLRequest(url: Webservice.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        if route.headers != nil {
            for (key, value) in route.headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do  {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeader):
                self.addAdditionalHeader(additionalHeader: additionalHeader, request: &request);
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .uploadData(let bodyParameters, let fileParameters, let additionalHeader):
                self.addAdditionalHeader(additionalHeader: additionalHeader, request: &request)
                self.upload(bodyParameters: bodyParameters, fileParameters: fileParameters, request: &request)
            }
            
            return request
            
        } catch {
            throw error
        }
    }
    
    fileprivate func upload(bodyParameters: Parameters?, fileParameters: Parameters?, request: inout URLRequest) {
        
        let type = "multipart/form-data; boundary=\(kBoundary)"
        request.setValue(type, forHTTPHeaderField: "Content-Type")
        if let data = fetchHttpBody(bodyParameters: bodyParameters, fileParameters: fileParameters) {
            request.httpBody = data
        }
    }
    
    
    fileprivate func fetchHttpBody(bodyParameters: Parameters?, fileParameters: Parameters?) -> Data?{
        var data = Data()
        
        if fileParameters != nil {
            for(k, v) in fileParameters! {
                let headerStr = "\r\n--\(kBoundary)\r\n" + "Content-Disposition: form-data; name=\"soundFile\"; filename=\"\(k)\"\r\n" + "Content-Type: audio/x-m4a\r\n\r\n";
                if let headerData = headerStr.data(using: String.Encoding.utf8) {
                    data.append(headerData)
                    if let d: Data = v as? Data {
                        data.append(d)
                    }
                }
            }
        }
        
        
        if bodyParameters != nil {
            for (k, v) in bodyParameters! {
                let headerStr = "\r\n--\(kBoundary)\r\n" + "Content-Disposition: form-data; name=\"\(k)\"\r\n\r\n" + "\(v)";
                if let headerData = headerStr.data(using: String.Encoding.utf8) {
                    data.append(headerData)
                }
            }
        }
        
        let footerStr = "\r\n--\(kBoundary)--\r\n";
        data.append(footerStr.data(using: .utf8)!)
        
        return data
    }
    
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    
    
    fileprivate func addAdditionalHeader(additionalHeader: HTTPHeaders?, request: inout URLRequest) {
        
        guard let headers = additionalHeader else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key);
        }
    }
}

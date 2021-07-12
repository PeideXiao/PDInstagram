//
//  ReviewAPI.swift
//  Voice
//
//  Created by Peide Xiao on 10/12/20.
//

import Foundation

enum ReviewAPI {
    case Watched(limit: Int, offset: Int)
    case SavedVideos(isPro:Int, limit: Int, offset: Int)
    case SavedWords(limit: Int, offset: Int, direction:String, key: String)
    case SavedCaptionLines(limit: Int, offset: Int, direction:String, key: String)
}


extension ReviewAPI: EndPointType {
    var path: String {
        switch self {
        case .Watched(_,_):
            return "v2.1/en/proVideos/watched"
        case .SavedVideos(_,_,_):
            return "v2.1/en/users/\(Constants.USER_ID)/savedVideos"
        case .SavedWords(_,_,_,_):
            return "v2.1.1/en/words/savedWordsWithDefinitions"
        case .SavedCaptionLines(_,_,_,_):
            return "v2.1/en/captionLines/saveCaptionLines"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        
        case .Watched(let limit, let offset):
            let parameters: [String: Any] = ["page[limit]": limit, "page[offset]": offset]
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
            
        case .SavedVideos(let isPro, let limit, let offset):
            let parameters: [String: Any] = ["page[limit]": limit, "page[offset]": offset, "filter[isPro]": isPro, "userId": Constants.USER_ID]
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
            
        case .SavedWords(let limit, let offset, let direction, let key):
            let parameters: [String: Any] = ["page[limit]": limit, "page[offset]": offset, "sort[direction]":direction, "sort[key]":key]
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
            
        case .SavedCaptionLines(let limit, let offset, let direction, let key):
            let parameters: [String: Any] = ["page[limit]": limit, "page[offset]": offset, "sort[direction]":direction, "sort[key]":key]
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization":Constants.AuthorizationKey]
    }
    
   
}

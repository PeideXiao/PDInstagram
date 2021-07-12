//
//  VideoAPI.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import Foundation

public enum VideoAPI {
    case Categories(lang: String, userId: String)
    case DailyPick
    case Video(query: String, lang: String, userId: String, analyticsKey:String, offset: Int, limit: Int)
    case VideoDetail(lang: String, videoId: Int)
}

extension VideoAPI: EndPointType {
    
    
    var path: String {
        switch self {
        case .Categories( _, _):
            return "/v2.1/en/categories"
        case .DailyPick:
            return "/v2.1/en/dailyPick"
        case .Video(_,_,_,_,_,_):
            return "/v2.1/en/videos";
        case .VideoDetail(_,let videoId):
            return "/v2.1.1/en/videos/\(videoId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    
    var task: HTTPTask {
        switch self {
        case .Categories(let lang, let userId):
            return .requestParameters(bodyParameters: nil, urlParameters: ["uiLanguage":lang, "userId":userId])
        case .DailyPick:
            return .request
        case .Video(let query, let lang, let userId, let analyticsKey, let offset, let limit):
            var dict: [String : Any] = ["uiLanguage":lang,
                        "userId":userId,
                        "page[offset]": offset,
                        "page[limit]": limit,
                        "analyticsKey": analyticsKey
            ];
            if let queryDict:[String: String] = query.splitToDictionary() {
                dict.merge(dict: queryDict);
            }
            
            return .requestParameters(bodyParameters: nil, urlParameters: dict)
        case .VideoDetail(lang: let lang, _):
            return .requestParameters(bodyParameters: nil, urlParameters: ["sysLang":lang])
        }
    }
    
    var headers: HTTPHeaders? {
//        return ["Accept-Encoding": "gzip, deflate, br",
//                "user-agengt":"VoiceTube/929 CFNetwork/1197 Darwin/20.0.0",
//                "version":"14.0",
//                "product":"VoiceTube",
//                "accept-language":"en-US",
//                "platform":"iOS",
//                "version":"3.3.67",
//                "cookie": "__cfduid=df5999c30c9c73ed8cc02aaa828744d881600975916",
//                ];
        
        return ["Authorization":Constants.AuthorizationKey]
    }
    
}

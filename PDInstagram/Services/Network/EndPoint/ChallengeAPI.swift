//
//  ChallengeAPI.swift
//  Voice
//
//  Created by Peide Xiao on 10/7/20.
//

import Foundation

enum ChallengeAPI {
    case Challenge(limit: Int, offset: Int)
    case ChallengeDetail(id: Int)
    case Comment(id: Int, mode: FetchMode, limit: Int, offset: Int)
    case SubmitComment(id: Int, byteData:Data?, text: String)
}

extension ChallengeAPI: EndPointType {
    var path: String {
        switch self {
        case .Challenge(_,_):
            return "v2.1/en/pronunciationChallenges"
        case .ChallengeDetail(let id):
            return "v2.1/en/pronunciationChallenges/\(id)"
        case .Comment(let id,_,_,_), .SubmitComment(let id, _, _):
            return "v2.1/en/pronunciationChallenges/\(id)/comments"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .Challenge(_,_):
            return .get
        case .ChallengeDetail(_):
            return .get
        case .Comment(_,_,_,_):
            return .get
        case .SubmitComment(_,_,_):
            return .post
        }
    }
    
    
    var task: HTTPTask {
        switch self {
        case .Challenge(let limit, let offset):
            let parameters:[String: Any] = [ "fetchMode":FetchMode.All.rawValue, "page[limit]": limit, "page[offset]": offset ];
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
        case .ChallengeDetail(_):
            return .requestParameters(bodyParameters: nil, urlParameters: ["userId": Constants.USER_ID])
        case .Comment(_, let mode, let limit, let offset):
            let parameters:[String: Any] = [ "fetchMode":mode.rawValue, "page[limit]": limit, "page[offset]": offset, "userId": Constants.USER_ID];
            return .requestParameters(bodyParameters: nil, urlParameters: parameters)
        case .SubmitComment(_, let byteData, let text):
            let parameters:[String: Any] = ["ownerId": Constants.USER_ID, "content": text ];
            var fileParameter:[String: Data]? = nil
            if byteData != nil {
                fileParameter = ["fileName": byteData!]
            }
            return .uploadData(bodyParameters: parameters, fileParameters: fileParameter, additionalHeader: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization":Constants.AuthorizationKey]
    }
    
    
    
    
    
}

enum FetchMode: String, Codable {
    case Mine = "myComments"
    case Others = "othersComments"
    case All = "all"
}

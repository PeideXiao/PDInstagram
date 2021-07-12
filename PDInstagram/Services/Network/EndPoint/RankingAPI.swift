//
//  RankAPI.swift
//  Voice
//
//  Created by Peide Xiao on 10/13/20.
//

import Foundation

enum RankingAPI {
    case UsersRankingList
    case RankRemainTime
}


extension RankingAPI: EndPointType {
    var path: String {
        switch self {
        case .UsersRankingList:
            return "v2.1/en/proRanking/usersRankingList"
        case .RankRemainTime:
            return "v2.1/en/proRanking/rankRemainTime"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .UsersRankingList:
            return .requestParameters(bodyParameters: nil, urlParameters: ["platform":"iOS", "userId": Constants.USER_ID])
        case .RankRemainTime:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization":Constants.AuthorizationKey]
    }
    
    
    
}

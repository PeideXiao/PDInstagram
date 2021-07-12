//
//  Webservice.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

struct Webservice {
    static let sharedInstance: Webservice = Webservice();
    static let enviroment: NetworkEnvironment = .production
    
    
    private let videoRouter = Router<VideoAPI>();
    private let challengeRouter = Router<ChallengeAPI>();
    private let reviewRouter = Router<ReviewAPI>();
    private let rankingRouter = Router<RankingAPI>();
    
    // ============================================================================
    // MARK: - Videos
    // ============================================================================
    
//    func getCategories(userId: String,  completion: @escaping (_ cagegories:[PDCategory]?, _ error:String?) -> Void) {
//        
//        videoRouter.request(.Categories(lang: "en", userId: userId)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let categoryData = try JSONDecoder().decode(ArrWrapper<PDCategory>.self, from: responseData)
//                        completion(categoryData.data, nil);
//                        
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                    
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    func getDailyPick(completion: @escaping (_ dailyPicks:[DailyPickItem]? , _ error: String?)->Void) {
//        videoRouter.request(.DailyPick) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        // print(jsonData)
//                        let categoryData = try JSONDecoder().decode(DictWrapper<DailyPickModel>.self, from: responseData)
//                        let resultDict = categoryData.data as DailyPickModel;
//                        completion(resultDict.items, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    func getVideos(query:String, userId:String, analyticsKey:String, offset:Int, limit:Int? = 50, completion: @escaping (_ videos: [VideoModel]?, _ error: String?)->()) {
//        videoRouter.request(.Video(query:query, lang: "en", userId: userId, analyticsKey: analyticsKey, offset: offset, limit: limit ?? 50)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        //                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(ArrWrapper<VideoModel>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    func getVideoDetail(videoId: Int, language: String? = "en", completion: @escaping (_ videoDetail: VideoDetailModel?, _ error: String?)->()) {
//        videoRouter.request(.VideoDetail(lang: language!, videoId: videoId)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        //                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(DictWrapper<VideoDetailModel>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    // ============================================================================
//    // MARK: - Pronunciation Challenges
//    // ============================================================================
//    
//    func getPronunciationChallenges(limit: Int? = 20, offset: Int, completion: @escaping(_ pronauciationChallenges: [ChallengeModel]?, _ error: String?)->()) {
//        challengeRouter.request(.Challenge(limit: limit!, offset: offset)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        let videoData = try JSONDecoder().decode(ArrWrapper<ChallengeModel>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//        
//    func getChallengeDetail(id: Int, completion: @escaping (_ detail: ChallengeDetailModel?, _ error: String?)->()){
//        challengeRouter.request(.ChallengeDetail(id: id)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
////                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(DictWrapper<ChallengeDetailModel>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    func getComments(id: Int, mode: FetchMode, limit: Int? = 20, offset: Int, completion: @escaping (_ comments: [Comment]?, _ error: String?)->()) {
//        challengeRouter.request(.Comment(id: id, mode: mode, limit: limit!, offset: offset)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let _ = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
////                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(ArrWrapper<Comment>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    func submitComment(id: Int, data: Data?, text: String, completion:@escaping (_ comment: Comment?, _ error: String?)->()) {
//        
//        challengeRouter.request(.SubmitComment(id: id, byteData: data, text: text)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(DictWrapper<Comment>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    // ============================================================================
//    // MARK: -- ReviewRouter
//    // ============================================================================
//    
//    func getWatchedVideos(limit: Int? = 20, offset: Int, completion:@escaping(_ videos:[VideoModel]?, _ error: String?)->()) {
//        reviewRouter.request(.Watched(limit: limit!, offset: offset)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
////                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(ArrWrapper<VideoModel>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    func getSavedVideos(limit: Int? = 20, offset: Int, completion:@escaping(_ videos:[VideoModel]?, _ error: String?)->()) {
//        reviewRouter.request(.SavedVideos(isPro: 1, limit: limit!, offset: offset)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
////                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(ArrWrapper<VideoModel>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    func getSavedWords(limit: Int? = 20, offset: Int, direction: String, key: String, completion:@escaping(_ words:[DictionaryWord]?, _ error: String?)->()) {
//        reviewRouter.request(.SavedWords(limit: limit!, offset: offset, direction: direction, key: key)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(ArrWrapper<DictionaryWord>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    func getSavedCaptionLines(limit: Int? = 20, offset: Int, direction: String, key: String, completion:@escaping(_ lines:[CaptionLine]?, _ error: String?)->()) {
//        reviewRouter.request(.SavedCaptionLines(limit: limit!, offset: offset, direction: direction, key: key)) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
////                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(ArrWrapper<CaptionLine>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    
//    // ============================================================================
//    // MARK: - Ranking
//    // ============================================================================
//    
//    func getUserRankingList(completion: @escaping(_ rank: RankList?, _ error: String?)->()) {
//        
//        rankingRouter.request(.UsersRankingList) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(DictWrapper<RankList>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
//    
//    func getRemainTime(completion: @escaping(_ remainTime: RemainTime?, _ error: String?)->()) {
//        
//        rankingRouter.request(.RankRemainTime) { (data, response, error) in
//            if error != nil { completion(nil, "Please check your network connection") }
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue);
//                        return
//                    }
//                    
//                    do {
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        print(jsonData)
//                        let videoData = try JSONDecoder().decode(DictWrapper<RemainTime>.self, from: responseData)
//                        completion(videoData.data, nil);
//                    } catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError);
//                }
//            }
//        }
//    }
//    
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return  .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue);
        }
    }
}


enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad Request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}


enum Result<String> {
    case success
    case failure(String)
}




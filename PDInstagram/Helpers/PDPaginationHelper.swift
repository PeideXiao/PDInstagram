//
//  PDPaginationHelper.swift
//  PDInstagram
//
//  Created by User on 7/7/21.
//

import Foundation

protocol PDKeyed {
    var key: String? { get set }
}

class PDPaginationHelper<T: PDKeyed> {
    
    enum PDPaginationState {
        case initial
        case ready
        case loading
        case end
    }
    
    let pageSize: UInt
    let serviceMethod: (UInt, String?, @escaping([T])->Void)-> Void
    var state: PDPaginationState = .initial
    var lastObjectKey: String?
    
    
    init(pageSize: UInt = 3, serviceMethod: @escaping (UInt, String?, @escaping(([T])->Void)) -> Void) {
        self.pageSize = pageSize
        self.serviceMethod = serviceMethod
    }
    
    func paginate(completion: @escaping ([T])-> Void) {
        
        switch state {
        
        case .initial:
            lastObjectKey = nil
            fallthrough
            
        case .ready:
            state = .loading
            serviceMethod(pageSize, lastObjectKey) { [unowned self] (objects:[T]) in
                defer {
                    if let objectKey = objects.last?.key{
                        self.lastObjectKey = objectKey
                    }
                }
                
                self.state = objects.count < self.pageSize ? .end : .ready
                guard let _ = lastObjectKey else {
                    return completion(objects)
                }
                
                let newObjects = Array(objects.dropFirst())
                completion(newObjects)
            }
            
        case .loading, .end:
            return
        }
    }
    
    func reloadData(completion: @escaping ([T])-> Void) {
        self.lastObjectKey = nil
        paginate(completion: completion)
    }
}

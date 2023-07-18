//
//  AlertHelper.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit
import Alamofire

protocol BaseRequestProtocol {
    
    func mockDataName() -> String?
    func method() -> HTTPMethod
    func apiPath() -> String?
    func headers() -> [String : String]?
    func parameters() -> [String : Any]?
    func rawData() -> Data?
    func encoding() -> ParameterEncoding
}

protocol CustomMap {
    
    func initMapping<T>(_ type: T.Type, dict: [String: Any]) -> T?
}

class BaseRequest: BaseRequestProtocol {
    
    func mockDataName() -> String? {
        return nil
    }
    
    func method() -> HTTPMethod {
        return .post
    }
    
    func apiPath() ->String? {
        return nil
    }
    
    func headers() -> [String : String]? {
        return nil
    }
    
    func parameters() -> [String : Any]? {
        return nil
    }
    
    func rawData() -> Data? {
        return nil
    }
    
    func encoding() -> ParameterEncoding {
        return URLEncoding.default
    }
    
    func performRequest<T:Decodable>(to classType: T.Type, completion: @escaping RequestClosure<T>) {
        RequestManager.shared.performRequest(self, to: classType, completion: completion)
    }
    
    func performRequestAsync<T:Decodable>(to classType: T.Type) async -> RequestResultCodable<T> {
        let result = await performRequestAsyncInternal(to: classType)
        return result
    }
    
    @MainActor private func performRequestAsyncInternal<T:Decodable>(to classType: T.Type) async -> RequestResultCodable<T> {
        return await withCheckedContinuation({ continuation in
            RequestManager.shared.performRequest(self, to: classType) { result in
                continuation.resume(returning: result)
            }
        })
    }
}

enum ResponseType {
    case success(r: Any)
    case error(e: String)
}

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

    func encoding()->ParameterEncoding {
        return URLEncoding.default
    }

    func performRequest<T:Decodable>(to classType: T.Type, completion: @escaping SimpleClosure<ResponseType>) {
        RequestManager.shared.performRequest(self, to: classType, completion: completion)
    }
    
    func uploadMiltipart<T:Decodable>(imageData: Data, to classType: T.Type, completion: @escaping SimpleClosure<ResponseType>) {
        RequestManager.shared.uploadMultipart(self, imageData: imageData, to: classType, completion: completion)
    }

}

enum ResponseType {
    case success(r: Any)
    case error(e: String)
}

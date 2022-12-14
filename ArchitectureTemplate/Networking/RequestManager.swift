//
//  AlertHelper.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import UIKit
import Alamofire

private let decoder = JSONDecoder()

enum RequestResultCodable<T: Decodable> {
    case success(response: T)
    case error(message: String?)
}

typealias RequestClosure<T:Decodable> = (RequestResultCodable<T>) -> ()

let parseErrorString = "Error, Please try later"
let parseBundleString = "Error on parse data from bundle"

final class RequestManager {

    static let shared = RequestManager()
    
    init() {
        AF.session.configuration.timeoutIntervalForRequest = 15.0
    }

    func performRequest<T: Decodable>(_ requestItem: BaseRequestProtocol, to classType: T.Type, completion: @escaping RequestClosure<T>) {
        
        if let filename = requestItem.mockDataName() { //use mock up
            returnDataFromMockup(filename: filename, requestItem: requestItem, to: classType, completion: completion)
            return
        }

        let fullPath = requestItem.apiPath() ?? ""
        let parameters:[String : Any] = requestItem.parameters() ?? [:]
        var headers:[String : String] = requestItem.headers() ?? [:]
        headers["Content-Type"] = "application/json"
        let httpHeaders:HTTPHeaders = HTTPHeaders(headers)
        
        //print("request \(headers)")
        print("fullPath \(fullPath)")
        print("parameters \(parameters)")
        //print("headers \(headers)")
        
        guard let path = fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let fullPathUrl = URL(string: path) else {
            completion(.error(message: "Common.Error"))
            return
        }
        
        guard let request = try? URLRequest(url: fullPathUrl, method: requestItem.method(), headers: httpHeaders) else {
            completion(.error(message: "Common.Error"))
            return
        }
        
        let encoding = requestItem.encoding()
        guard var encodedRequest = try? encoding.encode(request, with: parameters) else {
            completion(.error(message: "Common.Error"))
            return
        }
        
        if let jsonData = requestItem.rawData() {
            encodedRequest.httpBody = jsonData
        }
        
        let alamofireRequest:DataRequest = Alamofire.Session.default.request(encodedRequest)
        alamofireRequest.validate(statusCode: 200..<300).responseDecodable(of: classType) { response in
            if let respData = response.data, let stringValue = String(data: respData, encoding: .utf8) {
                print("performRequest stringValue \(stringValue)")
            }
            switch response.result {
                case .success(let item):
                print("performRequest success \(item)")
                    completion(.success(response: item))
                case .failure(let error):
                print("performRequest error \(error.localizedDescription)")
                    completion(.error(message: error.localizedDescription))
            }
        }
    }
    
    func parseJSON<T: Decodable>(from data: Data?, requestItem: BaseRequestProtocol, to classType: T.Type, completion: @escaping RequestClosure<T>) {
        guard let jsonData = data else {
            //showAlert(parseErrorString)
            completion(.error(message: parseErrorString))
            return
        }

        var errorStr = parseErrorString
        if let jsonResult = try? decoder.decode(classType, from: jsonData) {
            completion(.success(response: jsonResult))
            return
        } else { //print decode error for debug purposes
            do {
                _ = try decoder.decode(classType, from: jsonData)
            } catch let error {
                errorStr = error.localizedDescription
                
                if let decError = error as? DecodingError, let debugInfo = decError.localizedDebugInfo {
                    errorStr = debugInfo
                }
                print(error)
            }
        }
        
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] {
            if let message = dict["message"] as? String {
                //showAlert(message)
                completion(.error(message: message))
                return
            }

        }
        
        //showAlert(parseErrorString)
        completion(.error(message: errorStr))
    }
    
    private func showAlert(_ error: String) {
        HUDRenderer.hideHUD()
        AlertHelper.showAlert(error)
    }
}

//MARK: Mockup data
extension RequestManager {
    
    func returnDataFromMockup<T: Decodable>(filename: String, requestItem: BaseRequestProtocol, to classType: T.Type, completion: @escaping RequestClosure<T>) {
        
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                print("ReturnDataFromMockup \(filename)")
                parseJSON(from: data, requestItem: requestItem, to: classType, completion: completion)
                return
            }
        }
        
        //showAlert(parseBundleString)
        completion(.error(message: parseBundleString))
    }
}

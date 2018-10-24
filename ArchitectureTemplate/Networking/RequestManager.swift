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

let parseErrorString = "Error, Please try later"
//let parseBundleString = "Common.ErrorParseDataFromBundle"
let parseBundleString = "Error on rarse data from bundle"

final class RequestManager {

    static let shared = RequestManager()
    
    init() {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
    }

    func performRequest<T: Decodable>(_ requestItem: BaseRequestProtocol, to classType: T.Type, completion: @escaping SimpleClosure<ResponseType>) {
        
        if let filename = requestItem.mockDataName() { //use mock up
            returnDataFromMockup(filename: filename, requestItem: requestItem, to: classType, completion: completion)
            return
        }

        let fullPath = requestItem.apiPath() ?? ""
        let parameters:[String : Any] = requestItem.parameters() ?? [:]
        var headers:[String : String] = requestItem.headers() ?? [:]
        headers["Content-Type"] = "application/json"
        
        //print("request \(headers)")
        print("fullPath \(fullPath)")
        print("parameters \(parameters)")
        //print("headers \(headers)")
        
        guard let path = fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let fullPathUrl = URL(string: path) else {
            completion(.error(e: "Common.Error"))
            return
        }
        
        guard let request = try? URLRequest(url: fullPathUrl, method: requestItem.method(), headers: headers) else {
            completion(.error(e: "Common.Error"))
            return
        }
        
        let encoding = requestItem.encoding()
        guard var encodedRequest = try? encoding.encode(request, with: parameters) else {
            completion(.error(e: "Common.Error"))
            return
        }
        
        if let jsonData = requestItem.rawData() {
            encodedRequest.httpBody = jsonData
        }
        
        //let alamofireRequest:DataRequest = Alamofire.request(encodedRequest).debugLog()
        let alamofireRequest:DataRequest = Alamofire.request(encodedRequest)
        
        alamofireRequest.responseJSON { [weak self] response in
            switch response.result {
                case .success(let jsonSerialization):
                    //print("JSONSerialization \(dict)")
                    
                    //check for CustomMap protocol
                    if let customMapRequest = requestItem as? CustomMap, let dict = jsonSerialization as? [String : Any] {
                        if let items = customMapRequest.initMapping(classType, dict: dict) {
                            completion(.success(r: items as AnyObject))
                            return
                        }
                    }
                    
                    self?.parseJSON(from: response.data, requestItem: requestItem, to: classType, completion: completion)
                case .failure(let error):
                    self?.showAlert(error.localizedDescription);
                    completion(.error(e: error.localizedDescription))
            }
        }
    }
    
    func uploadMultipart<T: Decodable>(_ requestItem: BaseRequestProtocol, imageData: Data, to classType: T.Type, completion: @escaping SimpleClosure<ResponseType>) {
        let fullPath = requestItem.apiPath() ?? ""
        let headers:[String : String] = requestItem.headers() ?? [:]
        print("uploadMiltipart \(fullPath)")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "photo", fileName: "photo1.jpg", mimeType: "image/jpeg")
        }, usingThreshold: UInt64.init(), to: fullPath, method: requestItem.method(), headers: headers) { [weak self] encodingResult in
            switch encodingResult {
                case .success(let request, _, _):
                    request.responseJSON(completionHandler: { response in
                        switch response.result {
                            case .success(_):
                                //print("JSONSerialization \(dict)")
                                self?.parseJSON(from: response.data, requestItem: requestItem, to: classType, completion: completion)
                            case .failure(let error):
                                self?.showAlert(error.localizedDescription);
                                completion(.error(e: error.localizedDescription))
                        }
                    })
                case .failure(let error):
                    self?.showAlert(error.localizedDescription);
                    completion(.error(e: error.localizedDescription))
            }
        }
    }
    
    func parseJSON<T: Decodable>(from data: Data?, requestItem: BaseRequestProtocol, to classType: T.Type, completion: @escaping SimpleClosure<ResponseType>) {
        guard let jsonData = data else {
            //showAlert(parseErrorString)
            completion(.error(e: parseErrorString))
            return
        }

        var errorStr = parseErrorString
        if let jsonResult = try? decoder.decode(classType, from: jsonData) {
            completion(.success(r: jsonResult as AnyObject))
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
            if let message = dict?["message"] as? String {
                //showAlert(message)
                completion(.error(e: message))
                return
            }

        }
        
        //showAlert(parseErrorString)
        completion(.error(e: errorStr))
    }
    
    private func showAlert(_ error: String) {
        HUDRenderer.hideHUD()
        AlertHelper.showAlert(error)
    }
}

//MARK: Mockup data
extension RequestManager {
    
    func returnDataFromMockup<T: Decodable>(filename: String, requestItem: BaseRequestProtocol, to classType: T.Type, completion: @escaping SimpleClosure<ResponseType>) {
        
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                print("ReturnDataFromMockup \(filename)")
                parseJSON(from: data, requestItem: requestItem, to: classType, completion: completion)
                return
            }
        }
        
        //showAlert(parseBundleString)
        completion(.error(e: parseBundleString))
    }
}

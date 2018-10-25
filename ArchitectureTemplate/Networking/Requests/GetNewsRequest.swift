//
//  SignInRequest.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/25/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import Alamofire

class GetNewsRequest: BaseRequest {
    
    deinit {
        print("GetNewsRequest deinit")
    }
    
    override func mockDataName() -> String? {
        return "GetNewsRequest"
    }
    
    override func apiPath() -> String? {
        let path = Defines.serverURL + "news"
        return path
    }
    
    override func method() -> HTTPMethod {
        return .get
    }
    
    //#ToDiscuss
    func getNews(sBlock: @escaping SimpleClosure<[NewViewModel]>, eBlock: @escaping SimpleClosure<String>) {
        
        performRequest(to: [NewModel].self) { response in
            switch response {
            case .success(let responseObject):
                if let items = responseObject as? [NewModel] {
                    let models = items.map( { NewViewModel(new: $0) } )
                    sBlock(models)
                } else {
                    eBlock(parseErrorString)
                }
            case .error(let error):
                eBlock(error)
            }
        }
    }
}

//MARK:- Custom mapping
extension SignInRequest {

    //uncomment for custom request mapping
    /*func initMapping<T>(_ type: T.Type, dict: [String: Any]) -> T? {
        print("initMapping")
        return response as? T
    }*/
    
}

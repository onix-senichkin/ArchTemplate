//
//  SignInRequest.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import Alamofire

class SignInRequest: BaseRequest {
    
    private var email: String
    private var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    deinit {
        print("GetUserRequest deinit")
    }
    
    override func mockDataName() -> String? {
        return "GetUserRequest"
        //return nil
    }
    
    override func apiPath() -> String? {
        let path = Defines.loginEndpoint
        return path
    }
    
    override func parameters() -> [String : Any]? {
        return ["email": email,
                "password" : password]
    }
    
    override func method() -> HTTPMethod {
        return .post
    }
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    func perform(completion: @escaping RequestClosure<UserModel>) {
        RequestManager.shared.performRequest(self, to: UserModel.self, completion: completion)
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

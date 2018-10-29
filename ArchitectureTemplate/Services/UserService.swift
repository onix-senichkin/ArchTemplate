//
//  UserService.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.

import Foundation

protocol UserServiceType: Service {
    
    //getters
    var userName: String { get }
    var userEmail: String { get }
    
    //actions
    func login(email: String, password: String, completion: @escaping SimpleClosure<String?>)
    func logout()
}

class UserService: UserServiceType {
    
    private var userViewModel:UserViewModel? //#ToDiscuss view model or model? Maybe make empty on init
    
    deinit {
        print("UserService deinit")
    }
    
    //MARK: Actions
    func login(email: String, password: String, completion: @escaping SimpleClosure<String?>) {
        
        let request = SignInRequest(email: email, password: password)
        //#ToDiscuss move this to request, so request should return ViewModel instead
        request.performRequest(to: UserModel.self) { [weak self] response in
            switch response {
                case .success(let responseObject):
                    if let userModel = responseObject as? UserModel {
                        self?.userViewModel = UserViewModel(user: userModel)
                        completion(nil)
                    } else {
                      completion(parseErrorString)
                    }
                case .error(let error):
                    completion(error)
            }
        }
    }
    
    func logout() {
        userViewModel = nil
    }
    
    //MARK: Getters
    var userName: String {
        return userViewModel?.userName ?? "n/a"
    }
    
    var userEmail: String {
        return userViewModel?.userEmail ?? "n/a"
    }
}

//
//  GetNewsInfoRequest.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 18.07.2023.
//  Copyright © 2023 Denis Senichkin. All rights reserved.
//

import Foundation
import Alamofire

class GetNewsInfoRequest: BaseRequest {
    
    deinit {
        print("GetNewsInfoRequest deinit")
    }
    
    override func mockDataName() -> String? {
        return "GetNewsInfoRequest"
    }
    
    override func apiPath() -> String? {
        let path = Defines.baseEndpoint + "newsInfo"
        return path
    }
    
    override func method() -> HTTPMethod {
        return .get
    }
}

//
//  FeatureListService.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/26/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

protocol FeatureListServiceType: Service {
    
    //getters
    var bUseNewsListWithCompletion: Bool { get }
}

class FeatureListService: FeatureListServiceType {
    
    deinit {
        print("FeatureListService deinit")
    }
    
    //getters
    var bUseNewsListWithCompletion: Bool {
        return false
    }
}

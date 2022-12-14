//
//  ServiceHolder.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

public protocol Service {}
public protocol InitializableService: Service {
    init()
}

public class ServiceHolder {
    private var servicesDictionary: [String: Service] = [:]
    
    static var shared: ServiceHolder = ServiceHolder()
    
    private init() {}
    
    func add<T>(_ protocolType: T.Type, for instance: Service) {
        let name = String(reflecting: protocolType)
        servicesDictionary[name] = instance
    }
    
    func get<T>(by type: T.Type = T.self) -> T {
        return get(by: String(reflecting: type))
    }
    
    private func get<T>(by name: String) -> T {
        guard let service = servicesDictionary[name] as? T else {
            fatalError("firstly you have to add the service")
        }
        return service
    }
    
    func remove<T>(by type: T.Type) {
        let name = String(reflecting: type)
        if servicesDictionary[name] as? T != nil {
            servicesDictionary[name] = nil
        }
    }
}

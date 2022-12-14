//
//  DecodingError.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/24/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation

extension DecodingError {
    
    public var localizedDebugInfo: String? {
        switch  self {
            case .dataCorrupted(let context):
                return NSLocalizedString(context.debugDescription, comment: "")
            case .keyNotFound(_, let context):
                return NSLocalizedString("\(context.debugDescription)", comment: "")
            case .typeMismatch(_, let context):
                return NSLocalizedString("\(context.debugDescription)", comment: "")
            case .valueNotFound(_, let context):
                return NSLocalizedString("\(context.debugDescription)", comment: "")
            @unknown default:
                    return ""
        }
    }
}

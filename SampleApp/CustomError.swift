//
//  CustomError.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 04/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation

public enum CustomError: Error, LocalizedError {
    
    case alreadyConnected
    case alreadyConnecting
    case underlying(Error)
    public var errorDescription: String? {
        switch self {
        case .alreadyConnected:
            return "Device already connected."
        case .alreadyConnecting:
            return "Device already connecting."
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}

extension CustomError: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .alreadyConnected:
            return 0
        case .alreadyConnecting:
            return 1
        case .underlying:
            return 2
        }
    }
}

extension CustomError: Equatable {
    public static func ==(lhs: CustomError, rhs: CustomError) -> Bool {
        lhs.errorCode == rhs.errorCode
    }
}

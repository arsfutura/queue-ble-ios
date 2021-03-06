//
//  ConnectionResult+toResult.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 25/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

extension ConnectionResult {
    func toResult() -> Result<PeripheralIdentifier, Error> {
        switch self {
        case .success(let peripheralIdentifier):
            return .success(peripheralIdentifier)
        case .failure(let error):
            return .failure(CustomError.underlying(error))
        }
    }
}

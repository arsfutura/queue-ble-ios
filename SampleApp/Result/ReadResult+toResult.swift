//
//  ReadResult+toResult.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 18/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

extension ReadResult {
    func toResult() -> Result<R, Error> {
        switch self {
        case .success(let receivable):
            return .success(receivable)
        case .failure(let error):
            return .failure(CustomError.underlying(error))
        }
    }
}

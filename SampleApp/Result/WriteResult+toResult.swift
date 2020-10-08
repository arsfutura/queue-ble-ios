//
//  WriteResult+toResult.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 18/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

extension WriteResult {
    func toResult() -> Result<Void, Error> {
        switch self {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(CustomError.underlying(error))
        }
    }
}

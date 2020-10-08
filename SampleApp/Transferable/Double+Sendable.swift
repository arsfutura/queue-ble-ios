//
//  Double+Sendable.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 18/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

extension Double: Sendable {
    public func toBluetoothData() -> Data {
        var value = self
        return withUnsafeBytes(of: &value) { Data($0) }
    }
}

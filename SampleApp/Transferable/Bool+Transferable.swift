//
//  Bool+Receivable.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 14/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

extension Bool: Receivable, Sendable {
    public func toBluetoothData() -> Data {
        var byte: UInt8 = self ? 0x01 : 0x00
        return withUnsafeBytes(of: &byte) { Data($0) }
    }
    
    public init(bluetoothData: Data) throws {
        let byte: UInt8 = try bluetoothData.extract(start: 0, length: 1)
        self = byte == 0x01 ? true : false
    }
}

//
//  Float32+Receivable.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 18/11/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

extension Float32: Receivable {
    public init(bluetoothData: Data) throws {
        self = try bluetoothData.extract(start: 0, length: 4)
    }
}

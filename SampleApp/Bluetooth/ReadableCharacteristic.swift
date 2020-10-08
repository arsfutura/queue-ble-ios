//
//  ReadableCharacteristics.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 07/11/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay
import CoreBluetooth

struct ReadableCharacteristic<R> where R: Receivable {
    let identifier: CharacteristicIdentifier

    init(characteristic: CBUUID, service: CBUUID) {
        self.identifier = CharacteristicIdentifier(uuid: characteristic,
                                                   service: ServiceIdentifier(uuid: service))
    }
}

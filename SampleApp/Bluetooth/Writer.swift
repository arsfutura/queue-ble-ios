//
//  Writer.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 04/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay
import CoreBluetooth

protocol WriterProtocol {
    func write<S: Sendable>(to characteristic: WritableCharacteristic<S>,
                            value: S,
                            type: CBCharacteristicWriteType,
                            completion: @escaping (Result<Void, Error>) -> Void)
}

class Writer: WriterProtocol {
    
      private let sharedBluejay: Bluejay
      init(sharedBluejay: Bluejay = Bluejay.shared) {
          self.sharedBluejay = sharedBluejay
      }
    
    /// Write value for given characteristic.
    /// - Parameter key: unique characteristic identifier
    func write<S: Sendable>(to characteristic: WritableCharacteristic<S>,
                            value: S,
                            type: CBCharacteristicWriteType = .withoutResponse,
                            completion: @escaping (Result<Void, Error>) -> Void) {
        
        sharedBluejay.write(to: characteristic.identifier,
                            value: value,
                            type: type,
                            completion: { completion($0.toResult()) })
    }
}

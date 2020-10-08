//
//  Reader.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 04/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

protocol ReaderProtocol {
    func read<R: Receivable>(from characteristic: ReadableCharacteristic<R>, completion: @escaping (Result<R, Error>) -> Void)
}

class Reader: ReaderProtocol {
    
    private let sharedBluejay: Bluejay
    init(sharedBluejay: Bluejay = Bluejay.shared) {
        self.sharedBluejay = sharedBluejay
    }
    
    /// Reads value for given characteristic and returns it via completion function.
    /// - Parameter key: unique characteristic identifier
    /// - Parameter completion: is called when characteristic is read.
    func read<R: Receivable>(from characteristic: ReadableCharacteristic<R>, completion: @escaping (Result<R, Error>) -> Void) {
        sharedBluejay.read(from: characteristic.identifier, completion: { completion($0.toResult()) })
    }
}

//
//  Connector.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 21/10/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

protocol ConnectorProtocol {
    func connect(_ peripheralIdentifier: PeripheralIdentifier,
                 timeout: Timeout,
                 warningOptions: WarningOptions?,
                 completion: @escaping (Result<PeripheralIdentifier, Error>) -> Void)
    
    func disconnect(immediate: Bool, completion: ((Result<PeripheralIdentifier, Error>) -> Void)?)
    
    var isConnected: Bool { get }
    var isConnecting: Bool { get }
    
    func register(connectionObserver: ConnectionObserver)
    func unregister(connectionObserver: ConnectionObserver)
}

class Connector: ConnectorProtocol {
    
    private let sharedBluejay: Bluejay
    init(sharedBluejay: Bluejay = Bluejay.shared) {
        self.sharedBluejay = sharedBluejay
    }
    
    func connect(_ peripheralIdentifier: PeripheralIdentifier,
                 timeout: Timeout,
                 warningOptions: WarningOptions?,
                 completion: @escaping (Result<PeripheralIdentifier, Error>) -> Void) {
        sharedBluejay.connect(peripheralIdentifier, timeout: timeout, warningOptions: warningOptions, completion: { completion($0.toResult()) })
    }
    
    func disconnect(immediate: Bool,
                    completion: ((Result<PeripheralIdentifier, Error>) -> Void)?) {
        
        sharedBluejay.disconnect(immediate: immediate, completion: { completion?($0.toResult()) })
    }
    
    var isConnected: Bool { sharedBluejay.isConnected }
    
    var isConnecting: Bool { sharedBluejay.isConnecting }
    
    func register(connectionObserver observer: ConnectionObserver) {
        sharedBluejay.register(connectionObserver: observer)
    }
    
    func unregister(connectionObserver observer: ConnectionObserver) {
        sharedBluejay.unregister(connectionObserver: observer)
    }
}

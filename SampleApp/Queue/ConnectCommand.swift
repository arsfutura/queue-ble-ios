//
//  ConnectCommand.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 21/02/2020.
//  Copyright © 2020 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

class ConnectCommand: Command {
    weak var queue: CommandQueue?
    var onComplete: () -> () = { }

    private let connector: ConnectorProtocol
    private let identifier: PeripheralIdentifier
    private let warningOptions: WarningOptions?
    private let completion: (Result<PeripheralIdentifier, Error>) -> Void
    init(connector: ConnectorProtocol = Connector(),
         identifier: PeripheralIdentifier,
         warningOptions: WarningOptions?,
         completion: @escaping (Result<PeripheralIdentifier, Error>) -> Void) {
        
        self.connector = connector
        self.identifier = identifier
        self.warningOptions = warningOptions
        self.completion = completion
    }
    
    func execute() {
        if connector.isConnected {
            onComplete()
            complete(.failure(CustomError.alreadyConnected))
            print("ConnectCommand failed because SampleApp is already connected to a device.")
        } else if connector.isConnecting {
            onComplete()
            complete(.failure(CustomError.alreadyConnecting))
            print("ConnectCommand failed because SampleApp is already connecting to a device.")
        } else {
            connector.connect(identifier,
                              timeout: .none, // Blujay's request timeout has some issues so we don't use it for now.
                              warningOptions: warningOptions,
                              completion: complete(_:))
        }
    } 
    
    private func complete(_ result: Result<PeripheralIdentifier, Error>) {
        switch result {
        case .success(let identifier):
            print("Successfully connected to the device with uuid: \(identifier.uuid.uuidString)")
        case .failure(let error):
            print("Failed to connect due to: \(error.localizedDescription)")
        }
        
        completion(result)
        onComplete()
    }
    
    var description: String {
        "ConnectCommand(\(identifier.uuid.uuidString))"
    }
}

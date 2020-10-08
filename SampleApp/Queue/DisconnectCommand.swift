//
//  DisconnectCommand.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 21/02/2020.
//  Copyright © 2020 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

class DisconnectCommand: Command, Identifiable {
    var onComplete: () -> () = { }
    private let connector: ConnectorProtocol
    private let error: Error?
    private let completion: (Result<PeripheralIdentifier, Error>) -> Void
    init(connector: ConnectorProtocol = Connector(),
         error: Error? = nil,
         completion: @escaping (Result<PeripheralIdentifier, Error>) -> Void) {
        self.connector = connector
        self.completion = completion
        self.error = error
    }
    
    func execute() {
        if let error = error {
            print("Disconnect reason: \(error.localizedDescription)")
        }
        
        connector.disconnect(immediate: false) { [weak self] (result) in
            switch result {
            case .success(let identifier):
                print("Successfully disconnected from device with uuid: \(identifier.uuid.uuidString)")
            case .failure(let error):
                print("Failed to disconnect due to: \(error.localizedDescription)")
            }
            
            self?.completion(result)
            self?.onComplete()
        }
    }
    
    var description: String {
        "DisconnectCommand"
    }
}

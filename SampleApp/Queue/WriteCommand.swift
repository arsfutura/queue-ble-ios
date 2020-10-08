//
//  WriteCommand.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 21/02/2020.
//  Copyright © 2020 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

class WriteCommand<S>: Command where S: Sendable {
    private let characteristic: WritableCharacteristic<S>
    private let writer: WriterProtocol
    private let completion: ((Result<Void, Error>) -> ())
    private let value: S
    var onComplete: () -> () = { }
    init(characteristic: WritableCharacteristic<S>,
         value: S,
         writer: WriterProtocol = Writer(),
         completion: @escaping (Result<Void, Error>) -> ()) {
        
        self.characteristic = characteristic
        self.writer = writer
        self.completion = completion
        self.value = value
    }
    
    func execute() {
        writer.write(to: characteristic, value: value, type: .withResponse) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success:
                print(self.description + " executed successfully.")
            case .failure(let error):
                print(self.description + " failed due to error: \(error.localizedDescription)")
            }
            
            self.completion(result)
            self.onComplete()
        }
    }
    
    var description: String {
        "WriteCommand(Service: \(characteristic.identifier.description), Characteristic: \(characteristic.identifier.description))"
    }
}

//
//  ReadCommand.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 21/02/2020.
//  Copyright © 2020 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

class ReadCommand<R>: Command where R: Receivable {

    private let characteristic: ReadableCharacteristic<R>
    private let reader: ReaderProtocol
    var completion: ((Result<R, Error>) -> ())
    var onComplete: () -> () = { }
    init(characteristic: ReadableCharacteristic<R>,
         reader: ReaderProtocol = Reader(),
         completion: @escaping (Result<R, Error>) -> ()) {
        self.characteristic = characteristic
        self.reader = reader
        self.completion = completion
    }
    
    func execute() {
        reader.read(from: characteristic) { [weak self] (result) in
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
        "ReadCommand(Service: \(characteristic.identifier.description), Characteristic: \(characteristic.identifier.description))"
    }
}

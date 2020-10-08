//
//  ToggleCommand.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 28/09/2020.
//  Copyright © 2020 Ars Futura. All rights reserved.
//

import Foundation

class ToggleCommand: Command {
    private let readCharacteristic: ReadableCharacteristic<Bool>
    private let writeCharacteristic: WritableCharacteristic<Bool>

    private let reader: ReaderProtocol
    private let writer: WriterProtocol

    private let completion: ((Result<Void, Error>) -> ())
    var onComplete: () -> () = { }
    init(readCharacteristic: ReadableCharacteristic<Bool>,
         writeCharacteristic: WritableCharacteristic<Bool>,
         reader: ReaderProtocol = Reader(),
         writer: WriterProtocol = Writer(),
         completion: @escaping (Result<Void, Error>) -> ()) {
        
        self.readCharacteristic = readCharacteristic
        self.writeCharacteristic = writeCharacteristic
        
        self.reader = reader
        self.writer = writer
        
        self.completion = completion
    }
    
    func execute() {
        reader.read(from: readCharacteristic) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let oldValue):
                let newValue = !oldValue
                self.write(value: newValue)
            
            case .failure(let error):
                print(self.description + " failed due to: \(error.localizedDescription)")
            }
        }
    }
    
    private func write(value: Bool) {
        writer.write(to: writeCharacteristic, value: value, type: .withoutResponse) { [weak self] (result) in
            guard let `self` = self else { return }

            switch result {
            case .success:
                print(self.description + " was successfull.")
            case .failure(let error):
                print(self.description + " failed due to: \(error.localizedDescription)")
            }
            
            self.completion(result)
            self.onComplete()
        }
    }
    
    var description: String {
        """
        ToggleCommand(Service: \(readCharacteristic.identifier.description), Characteristic: \(readCharacteristic.identifier.description))
        """
    }
}

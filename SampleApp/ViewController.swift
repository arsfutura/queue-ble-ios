//
//  ViewController.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 16/09/2020.
//  Copyright © 2020 Ars Futura. All rights reserved.
//

import UIKit
import SnapKit
import Bluejay
import CoreBluetooth

class ViewController: UIViewController {
    private let characteristicUUID = CBUUID(string: "0x1112")
    private let serviceUUID = CBUUID(string: "0x1111")
    private let deviceName = "Galaxy S7 edge"

    private lazy var boolReadCharacteristic = ReadableCharacteristic<Bool>(characteristic: characteristicUUID,
                                                             service: serviceUUID)
    private lazy var boolWriteCharacteristic = WritableCharacteristic<Bool>(characteristic: characteristicUUID,
                                                            service: serviceUUID)

    private var scanner: BluetoothScannerProtocol = BluetoothScanner()
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Start", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        scanner.scan(duration: 10,
                     allowDuplicates: false,
                     throttleRSSIDelta: 5,
                     serviceIdentifiers: nil,
                     discovery: deviceWasDiscovered(newDiscovery:discoveries:),
                     expired: nil,
                     stopped: { (_,_) in return })
    }
    
    private func deviceWasDiscovered(newDiscovery: ScanDiscovery, discoveries: [ScanDiscovery]) -> ScanAction {
        guard newDiscovery.peripheralIdentifier.name == deviceName else {
            return .continue
        }
        
        queue.add(ConnectCommand(identifier: newDiscovery.peripheralIdentifier,
                                 warningOptions: nil,
                                 completion: { _ in }))

        queue.add(ReadCommand(characteristic: boolReadCharacteristic, completion: { (result) in
            print("Read before toggle: \(result)")
        }))
        
        queue.add(ToggleCommand(readCharacteristic: boolReadCharacteristic, writeCharacteristic: boolWriteCharacteristic, completion: { _ in }))
        
        queue.add(ReadCommand(characteristic: boolReadCharacteristic, completion: { (result) in
            print("Read after toggle: \(result)")
        }))
        
        queue.add(DisconnectCommand(completion: { _ in }))
        
        return .stop
    }
    
}

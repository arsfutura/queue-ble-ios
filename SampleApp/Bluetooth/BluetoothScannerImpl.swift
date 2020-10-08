//
//  BluetoothService.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 27/09/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

protocol BluetoothScannerProtocol {
    func scan(
        duration: TimeInterval,
        allowDuplicates: Bool,
        throttleRSSIDelta: Int,
        serviceIdentifiers: [ServiceIdentifier]?,
        discovery: @escaping (ScanDiscovery, [ScanDiscovery]) -> ScanAction,
        expired: ((ScanDiscovery, [ScanDiscovery]) -> ScanAction)?,
        stopped: @escaping ([ScanDiscovery], Error?) -> Void
    )
    
    func stopScanning()
    
    var isScanning: Bool { get }
}

class BluetoothScanner: BluetoothScannerProtocol {
   
    private let sharedBluejay: Bluejay
    init(sharedBluejay: Bluejay = Bluejay.shared) {
        self.sharedBluejay = sharedBluejay
    }
    
    func scan(duration: TimeInterval,
              allowDuplicates: Bool,
              throttleRSSIDelta: Int,
              serviceIdentifiers: [ServiceIdentifier]?,
              discovery: @escaping (ScanDiscovery, [ScanDiscovery]) -> ScanAction,
              expired: ((ScanDiscovery, [ScanDiscovery]) -> ScanAction)?,
              stopped: @escaping ([ScanDiscovery], Error?) -> Void) {
        
        sharedBluejay.scan(duration: duration,
                            allowDuplicates: allowDuplicates,
                            throttleRSSIDelta: throttleRSSIDelta,
                            serviceIdentifiers: serviceIdentifiers,
                            discovery: discovery,
                            expired: expired,
                            stopped: stopped)
    }
    
    var isScanning: Bool { sharedBluejay.isScanning }
    
    func stopScanning() {
        sharedBluejay.stopScanning()
    }

}

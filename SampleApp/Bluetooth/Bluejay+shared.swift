//
//  Bluejay+shared.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 27/09/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay
extension Bluejay {
    static var shared: Bluejay = {
        let newInstance = Bluejay()
        newInstance.start()
        return newInstance
    }()
}

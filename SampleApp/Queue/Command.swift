//
//  Command.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 21/02/2020.
//  Copyright © 2020 Ars Futura, Inc. All rights reserved.
//

import Foundation

protocol Command: CustomStringConvertible {
    func execute()
    var onComplete: () -> () { get set }
}

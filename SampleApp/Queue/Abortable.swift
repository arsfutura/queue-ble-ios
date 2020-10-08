//
//  Undoable.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 21/02/2020.
//  Copyright © 2020 Ars Futura, Inc. All rights reserved.
//

import Foundation

public protocol Abortable {
    var isAborted: Bool { get }
    func abort(_ completion: @escaping (Result<Void, Error>) -> ())
}

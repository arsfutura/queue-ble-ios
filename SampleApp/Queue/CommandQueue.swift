//
//  CommandQueue.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 19/02/2020.
//  Copyright © 2020 Ars Futura, Inc. All rights reserved.
//

import Foundation
import Bluejay

class CommandQueue: Queue<Command> {
    override func add(_ newElement: Command) {
        var newElement = newElement
        newElement.onComplete = next
        super.add(newElement)
    }
}

var queue: CommandQueue = CommandQueue { command in
    print("Executing \(command.description)")
    command.execute()
}


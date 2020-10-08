//
//  Queue.swift
//  SampleApp
//
//  Created by Lovro Bunicic on 16/12/2019.
//  Copyright © 2019 Ars Futura, Inc. All rights reserved.
//

import Foundation

/// Auto feeding queue calls consumer function when element is removed frome the queue.
class Queue<Element> {
    private var array: [Element] = []
    var onNext: ((Element) -> ())?
    private let deferStart: Bool
    init(deferStart: Bool = false, onNext: ((Element) -> ())? = nil) {
        self.onNext = onNext
        self.deferStart = deferStart
    }
    
    /// Adds element to the queue.
    /// - Parameter element: New element that is being added to the queue.
    func add(_ newElement: Element) {
        array.append(newElement)
        if array.count == 1, deferStart == false {
            onNext?(newElement)
        }
    }
    
    func insert(_ newElement: Element, at index: Int) {
        array.insert(newElement, at: index)
    }
    
    /// Returns and removes current element from the queue. Delivers next element to the consumer function.
    func pop() -> Element? {
        defer {
            if let next = array.first {
                onNext?(next)
            }
        }
        
        let current = array.first
        if !array.isEmpty {
            array.removeFirst()
        }
        
        return current
    }
    
    func peek() -> Element? {
        array.first
    }
    
    func start() {
        if let next = array.first {
            onNext?(next)
        }
    }
    
    func next() {
        if !array.isEmpty {
            array.removeFirst()
        }
        
        if let next = array.first {
            onNext?(next)
        }
    }
    
    func removeAll() {
        array.removeAll()
    }
    
    func remove(fromIndex: Int) {
        array.removeSubrange(fromIndex..<array.count)
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
    
    func forEach(body: (Element) -> Void) {
        array.forEach(body)
    }
    
    var asArray: [Element] { array }
}

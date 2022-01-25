//
//  Cancellable.swift
//  Async Image Loading
//
//  Created by Sachin Ambegave on 26/01/22.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {
    // We don't need to add method of `Cancellable` protocol as `URLSessionTask` already contains the method with exact same name
}

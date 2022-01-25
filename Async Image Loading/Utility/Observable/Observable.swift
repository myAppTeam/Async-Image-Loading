//
//  Observable.swift
//  Async Image Loading
//
//  Created by Sachin Ambegave on 25/01/22.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    typealias ObserverClosure = (T?) -> Void
    
    private var observer: ObserverClosure?
    
    func bind(_ observer: @escaping ObserverClosure) {
        self.observer = observer
    }
}

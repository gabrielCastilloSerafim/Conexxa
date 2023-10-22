//
//  UserDefaultsObservation.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

class UserDefaultsObservation: NSObject {

    // MARK: Lifecycle

    init(key: Key, onChange: @escaping (Any, Any) -> Void) {
        self.onChange = onChange
        self.key = key
        super.init()
        UserDefaults.standard.addObserver(self, forKeyPath: key.rawValue, options: [.old, .new], context: nil)
    }

    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: key.rawValue, context: nil)
    }

    // MARK: Internal

    let key: Key

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?)
    {
        guard let change = change, object != nil, keyPath == key.rawValue else { return }
        onChange(change[.oldKey] as Any, change[.newKey] as Any)
    }

    // MARK: Private

    private var onChange: (Any, Any) -> Void
}

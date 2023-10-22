//
//  UserDefaultsPropertyWrapper.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 16/9/23.
//

import Foundation

@propertyWrapper
struct UserDefault<T: PropertyListValue> {
    let key: Key

    var wrappedValue: T? {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }

    var projectedValue: UserDefault<T> { self }

    func observe(change: @escaping (T?, T?) -> Void) -> NSObject {
        UserDefaultsObservation(key: key) { old, new in
            change(old as? T, new as? T)
        }
    }
}

// MARK: - Key

struct Key: RawRepresentable {
    let rawValue: String
}

// MARK: ExpressibleByStringLiteral

extension Key: ExpressibleByStringLiteral {

    init(stringLiteral: String) {
        self.rawValue = stringLiteral
    }

}

// MARK: - PropertyListValue

// The marker protocol
protocol PropertyListValue {}

// MARK: - Data + PropertyListValue

extension Data: PropertyListValue {}

// MARK: - String + PropertyListValue

extension String: PropertyListValue {}

// MARK: - Date + PropertyListValue

extension Date: PropertyListValue {}

// MARK: - Bool + PropertyListValue

extension Bool: PropertyListValue {}

// MARK: - Int + PropertyListValue

extension Int: PropertyListValue {}

// MARK: - Double + PropertyListValue

extension Double: PropertyListValue {}

// MARK: - Float + PropertyListValue

extension Float: PropertyListValue {}

// MARK: - Array + PropertyListValue

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}

// MARK: - Dictionary + PropertyListValue

extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

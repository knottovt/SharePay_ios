//
//  UserDataManager.swift
//  SharePay
//
//  Created by Visarut Tippun on 3/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

class UserDataManager {
    
    static let shared = UserDataManager()
    private let userDefaults = UserDefaults.standard
    
    func clearAllUserData() {
        self.userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    func setValue(_ value:Any?, forKey key:String){
        self.userDefaults.set(value, forKey: key)
        self.userDefaults.synchronize()
    }
    
    func valueForKey(key:String) -> Any? {
        return self.userDefaults.value(forKey: key)
    }
    
    func saveBool(_ bool:Bool, forKey key: String) {
        self.userDefaults.set(bool, forKey: key)
        self.userDefaults.synchronize()
    }
    
    func boolForKey(key:String) -> Bool {
        return self.userDefaults.bool(forKey: key)
    }
   
}

extension UserDataManager {
    // MARK: Save/Retieve generic object(s)
    func saveObject<T : Encodable>(_ object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            self.setValue(data, forKey: key)
        } catch {
            print("can't save \(T.self) error: \(error)")
        }
    }
    
    func retrieveObject<T: Decodable>(type: T.Type, key:String) -> T? {
        guard let data = self.userDefaults.data(forKey: key),
            let object = try? JSONDecoder().decode(type, from: data) else { return nil }
        return object
    }
    
}

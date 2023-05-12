//
//  DatabaseManager.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 12.05.2023.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func canCreateNewUser(with email: String, username: String, password: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, password: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}


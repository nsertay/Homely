//
//  Extensions.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 12.05.2023.
//

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "")
    }
}

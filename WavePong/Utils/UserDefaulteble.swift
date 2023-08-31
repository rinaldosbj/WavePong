//
//  UserDefaulteble.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import Foundation


protocol UserDefaultable {
    func bool(forKey: String) -> Bool
    
    func integer(forKey: String) -> Int
    
    func set(_ value: Bool, forKey defaultName: String)
    
    func set(_ value: Int, forKey defaultName: String)
    
}

extension UserDefaults: UserDefaultable {
    
}

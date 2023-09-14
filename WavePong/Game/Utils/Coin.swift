//
//  Coin.swift
//  WavePong
//
//  Created by LoreVilaca on 13/09/23.
//

class Coin {
    private var balance: Int = 0
    
    func addCoins (amount: Int) {
        self.balance += amount
    }
    
    func subtractCoins (amount: Int) {
        if self.balance >= amount {
            self.balance -= amount
        }
    }
    
    func getCoins () -> Int {
        return self.balance
    }
    
}

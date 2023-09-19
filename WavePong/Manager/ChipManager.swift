//
//  Coin.swift
//  WavePong
//
//  Created by LoreVilaca on 13/09/23.
//
import SwiftUI

class ChipManager {
    
    static let shared = ChipManager()
    
    let chipKey: String = "totalCoins"
    let lastDatePlayedKey: String = "lastDatePlayed"
    
    @Published var totalChips: Int = 0
    @Published var chipsCollectedToday: Int = 0
    
    var lastDatePlayed = Date()
    var currentDate = Date ()
    
    func addChips(_ amount: Int) {
        if chipsCollectedToday < 30 {
            totalChips += amount
            chipsCollectedToday += amount
            saveChips()
        }
        updateLastPlayedDate()
    }
    
    func saveChips() {
        UserDefaults.standard.set(totalChips, forKey: chipKey)
    }
    
    func loadChips() {
        totalChips = UserDefaults.standard.integer(forKey: chipKey)
        resetDailyChipsIfNecessary()
    }
    
    func calculateChipsForScore(_ score: Int) {
        let chipsEarned = Int(Double(score) * 0.1)
        print("Você ganhou fichas!")
        print(chipsEarned)
        addChips(chipsEarned)
    }
    
    func canDoubleChips() -> Bool {
        return chipsCollectedToday == 30
    }
    
    func resetDailyChipsIfNecessary() {
        if isFirstGameToday() {
            chipsCollectedToday = 0
        }
    }
    
    func isFirstGameToday () -> Bool {
        lastDatePlayed = UserDefaults.standard.object(forKey: lastDatePlayedKey) as? Date ?? Date.distantPast
        currentDate = Date()

        return !Calendar.current.isDate(lastDatePlayed, inSameDayAs: currentDate)
    }
    
    func updateLastPlayedDate() {
        currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: lastDatePlayedKey)
    }
    
    func collectFirstGameChips () {
        addChips(3)
    }
    
    func doubleChips() {
        if canDoubleChips() {
            totalChips += chipsCollectedToday
            chipsCollectedToday = 0
            saveChips()
        }
    }
}

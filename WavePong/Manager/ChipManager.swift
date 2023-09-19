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
        addChips(chipsEarned)
    }
    
    func canDoubleChips() -> Bool {
        return chipsCollectedToday == 30
    }
    
    func resetDailyChipsIfNecessary() {
        if isFirstGameToday() {
            //Se o dia atual não é o dia do último jogo, redefinir última data para hoje
            chipsCollectedToday = 0
            updateLastPlayedDate()
        }
    }
    
    func isFirstGameToday () -> Bool {
        lastDatePlayed = UserDefaults.standard.object(forKey: "lastClaimedDate") as? Date ?? Date.distantPast
        currentDate = Date()
        
        return !Calendar.current.isDate(lastDatePlayed, inSameDayAs: currentDate)
    }
    
    func updateLastPlayedDate() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: "lastPlayedDate")
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

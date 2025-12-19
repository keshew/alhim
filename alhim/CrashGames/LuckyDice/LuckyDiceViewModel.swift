import SwiftUI

class LuckyDiceViewModel: ObservableObject {
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var maxBet = 0
    @Published var isFlipping = false
    @Published var rotationStep = 0
    @Published var totalRotations = 0
    @Published var lastWin = 0
    @Published var currentDice = "dicehol"
    
    private var generatedDiceNumber = 1

    init() {
        updateMaxBet()
    }
    
    func updateMaxBet() {
        maxBet = coin
    }

    func maxBetAction() {
        bet = maxBet
    }

    func startFlip() {
        guard !isFlipping, bet <= coin else { return }
        
        UserDefaultsManager.shared.removeCoins(bet)
        coin = UserDefaultsManager.shared.coins
        
        generatedDiceNumber = Int.random(in: 1...6)
        totalRotations = Int.random(in: 5...7)
        rotationStep = 0
        isFlipping = true
        currentDice = "dice1"
        
        runRotationAnimation()
    }

    private func runRotationAnimation() {
        guard rotationStep < totalRotations else {
            currentDice = "dice\(generatedDiceNumber)"
            isFlipping = false
            
            let isWin = generatedDiceNumber >= 4
            
            if isWin {
                let winAmount = bet * 3
                UserDefaultsManager.shared.addCoins(winAmount)
                UserDefaultsManager.shared.playGame()
                UserDefaultsManager.shared.placeBet(bet)
                UserDefaultsManager.shared.winCoinFlip()
                coin = UserDefaultsManager.shared.coins
                lastWin = winAmount
                UserDefaultsManager.shared.recordWin(winAmount)
            } else {
                lastWin = 0
                coin = UserDefaultsManager.shared.coins
            }
            
            updateMaxBet()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.resetGame()
            }
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.rotationStep += 1
            self.runRotationAnimation()
        }
    }
    
    private func resetGame() {
        isFlipping = false
        rotationStep = 0
        currentDice = "dice1"
        coin = UserDefaultsManager.shared.coins
    }
}

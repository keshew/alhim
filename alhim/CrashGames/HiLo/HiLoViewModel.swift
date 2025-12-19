import SwiftUI

class HiLoViewModel: ObservableObject {
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var maxBet = 0
    @Published var isTail = false
    @Published var isFlipping = false
    @Published var rotationStep = 0
    @Published var totalRotations = 0
    @Published var lastWin = 0
    @Published var currentNumber = "?"
    
    private var userChoiceIsTail: Bool = false
    private var generatedNumber = 0

    init() {
        updateMaxBet()
    }
    
    func updateMaxBet() {
        maxBet = coin
    }

    func maxBetAction() {
        bet = maxBet
    }

    func startFlip(userChoice: Bool) {
        guard !isFlipping, bet <= coin else { return }
        
        UserDefaultsManager.shared.removeCoins(bet)
        coin = UserDefaultsManager.shared.coins
        
        userChoiceIsTail = userChoice
        generatedNumber = Int.random(in: 1...10)
        totalRotations = Int.random(in: 5...7)
        rotationStep = 0
        isFlipping = true
        currentNumber = "?"
        
        runRotationAnimation()
    }

    private func runRotationAnimation() {
        guard rotationStep < totalRotations else {
            currentNumber = "\(generatedNumber)"
            isFlipping = false
            
            let isWin = (userChoiceIsTail && generatedNumber <= 5) || (!userChoiceIsTail && generatedNumber >= 6)
            
            if isWin {
                let winAmount = bet * 2
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
        currentNumber = "?"
        coin = UserDefaultsManager.shared.coins
    }
}

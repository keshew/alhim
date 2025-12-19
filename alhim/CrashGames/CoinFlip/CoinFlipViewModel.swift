import SwiftUI

class CoinFlipViewModel: ObservableObject {
    let contact = CoinFlipModel()
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var maxBet = 0
    @Published var isTail = false
    @Published var isFlipping = false
    @Published var rotationStep = 0
    @Published var totalRotations = 0
    @Published var lastWin = 0
    @Published var showQuestionMark = true

    private var userChoiceIsTail: Bool = false
    private var finalResultTail: Bool = false
    var onFlipResult: ((Bool) -> Void)? = nil

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
        totalRotations = Int.random(in: 5...7)
        finalResultTail = (totalRotations % 2 != 0)
        rotationStep = 0
        isFlipping = true
        showQuestionMark = true
        
        runRotationAnimation()
    }

    private func runRotationAnimation() {
        guard rotationStep < totalRotations else {
            isFlipping = false
            isTail = finalResultTail
            showQuestionMark = false

            if userChoiceIsTail == finalResultTail {
                let winAmount = bet * 2
                UserDefaultsManager.shared.addCoins(winAmount)
                UserDefaultsManager.shared.playGame()
                UserDefaultsManager.shared.placeBet(bet)
                UserDefaultsManager.shared.playGame()
                UserDefaultsManager.shared.winCoinFlip()
                coin = UserDefaultsManager.shared.coins
                lastWin = winAmount
                UserDefaultsManager.shared.recordWin(winAmount)
                onFlipResult?(true)
            } else {
                lastWin = 0
                coin = UserDefaultsManager.shared.coins
                onFlipResult?(false)
            }
            updateMaxBet()
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.rotationStep += 1
            self.runRotationAnimation()
        }
    }
}

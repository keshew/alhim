import SwiftUI

class RPSViewModel: ObservableObject {
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var maxBet = 0
    @Published var isFlipping = false
    @Published var shakeAmount: CGFloat = 0
    @Published var lastWin = 0
    @Published var playerChoice: RPSChoice? = nil
    @Published var computerChoice: RPSChoice? = nil
    @Published var showComputerChoice = false
    
    enum RPSChoice: String, CaseIterable {
        case rock = "rock"
        case paper = "paper"
        case scissors = "scissors"
        
        func beats(_ other: RPSChoice) -> Bool {
            switch self {
            case .rock: return other == .scissors
            case .paper: return other == .rock
            case .scissors: return other == .paper
            }
        }
    }

    init() {
        updateMaxBet()
    }
    
    func updateMaxBet() {
        maxBet = coin
    }

    func maxBetAction() {
        bet = maxBet
    }

    func selectChoice(_ choice: RPSChoice) {
        guard !isFlipping else { return }
        playerChoice = choice
    }
    
    func startGame() {
        guard !isFlipping, bet <= coin, let player = playerChoice else { return }
        
        UserDefaultsManager.shared.removeCoins(bet)
        coin = UserDefaultsManager.shared.coins
        
        isFlipping = true
        shakeAmount = 0
        showComputerChoice = false
        
        let possibleChoices = RPSChoice.allCases.filter { $0 != player }
        computerChoice = possibleChoices.randomElement()!
        
        withAnimation(.easeInOut(duration: 1.5).repeatCount(6, autoreverses: true)) {
            shakeAmount = 15
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.showComputerChoice = true
            }
            self.finishGame(playerChoice: player)
        }
    }
    
    private func finishGame(playerChoice: RPSChoice) {
        shakeAmount = 0
        let isWin = playerChoice.beats(computerChoice!)
        
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.resetGame()
        }
    }
    
    private func resetGame() {
        isFlipping = false
        playerChoice = nil
        computerChoice = nil
        showComputerChoice = false 
        shakeAmount = 0
        coin = UserDefaultsManager.shared.coins
    }

}

import SwiftUI
import Combine

struct WheelSegment: Identifiable {
    let id = UUID()
    let title: String
    let prize: Double
    let color: Color
}

class FortuneViewModel: ObservableObject {
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet = 50
    @Published var win = 0
    @ObservedObject private var soundManager = SoundManager.shared
    @Published var maxBet = 0
    
    init() {
        updateMaxBet()
    }
    
    func updateMaxBet() {
        maxBet = coin
    }

    func maxBetAction() {
        bet = maxBet
    }
    
    @Published var segments: [WheelSegment] = [
        WheelSegment(title: "10x", prize: 10, color: Color(red: 211/255, green: 22/255, blue: 230/255)),
        WheelSegment(title: "1x", prize: 1, color: Color(red: 254/255, green: 206/255, blue: 26/255)),
        WheelSegment(title: "3x", prize: 3, color: Color(red: 40/255, green: 220/255, blue: 255/255)),
        WheelSegment(title: "0.5x", prize: Double(0.5), color: Color(red: 216/255, green: 11/255, blue: 100/255)),
        WheelSegment(title: "2x", prize: 2, color: Color(red: 69/255, green: 10/255, blue: 234/255)),
        WheelSegment(title: "1x", prize: 1, color: Color(red: 3/255, green: 161/255, blue: 135/255)),
        WheelSegment(title: "5x", prize: 5, color: Color(red: 151/255, green: 151/255, blue: 151/255)),
        WheelSegment(title: "1.5x", prize: Double(1.5), color: Color(red: 53/255, green: 253/255, blue: 26/255))
    ]
    
    @Published var isSpinning = false
    @Published var rotationDegree: Double = 0
    private var cancellables = Set<AnyCancellable>()
    private var userDefaults = UserDefaultsManager.shared
    @Published private(set) var balance: Double = 0
    @Published var alertMessage: String? = nil
    
    @Published var selectedSegmentIndex: Int? = nil
     @Published var betAmount: Double = 0
    
    func spinWheel() {
         guard !isSpinning else { return }
        soundManager.playSoundBtn()
         win = 0
         guard let selectedIndex = selectedSegmentIndex else {
             alertMessage = "Please select a segment before spinning."
             return
         }
         
        guard bet > 0 && bet <= coin else {
             alertMessage = "Please set a valid bet amount."
             return
         }
         
         isSpinning = true
        UserDefaultsManager.shared.playGame()
        UserDefaultsManager.shared.playGame()
        let _ = UserDefaultsManager.shared.removeCoins(bet)
        UserDefaultsManager.shared.placeBet(bet)
        coin = UserDefaultsManager.shared.coins
        
         let fullRotations = Double.random(in: 3...6)
         let randomAngle = Double.random(in: 0..<360)
         let newRotation = rotationDegree + fullRotations * 360 + randomAngle
         
         withAnimation(.easeOut(duration: 3)) {
             rotationDegree = newRotation
         }
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
             let normalizedDegree = (self.rotationDegree.truncatingRemainder(dividingBy: 360))
             let segmentAngle = 360.0 / Double(self.segments.count)
             let index = Int(Double(self.segments.count) - (normalizedDegree / segmentAngle)) % self.segments.count
             
             if index == selectedIndex {
                 let prize = self.segments[index].prize * Double(self.bet)
                 self.win = Int(prize)
                 self.applyPrize(Int(prize))
                 self.alertMessage = "You won $\(String(format: "%.2f", prize))!"
             } else {
                 self.alertMessage = "You lost your bet. Try again!"
             }
             
             self.isSpinning = false
             self.soundManager.stopWrong()
         }
     }
     
    private func applyPrize(_ prize: Int) {
         win = prize
         UserDefaultsManager.shared.addCoins(win)
        UserDefaultsManager.shared.recordWin(win)
         coin = UserDefaultsManager.shared.coins
     }
    
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct SectorShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center,
                    radius: rect.width/2,
                    startAngle: startAngle - Angle(degrees: 90),
                    endAngle: endAngle - Angle(degrees: 90),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}

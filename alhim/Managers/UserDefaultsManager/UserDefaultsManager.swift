import SwiftUI

class UserDefaultsManager: ObservableObject {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private let achievementsKey = "achievements"
    private let missionsKey = "missions"
    
    var coins: Int {
        get { defaults.integer(forKey: "coins") }
        set { defaults.set(newValue, forKey: "coins") }
    }
    
    func addCoins(_ amount: Int) {
        coins += amount
    }
    
    func removeCoins(_ amount: Int) {
        coins = max(coins - amount, 0)
    }
    
    // Achievements
    @Published var achievements: [Missions] = [] {
        didSet {
            saveAchievements()
            checkAchievementCompletion()
        }
    }
    
    // Missions
    @Published var missions: [Missions] = [] {
        didSet {
            saveMissions()
            checkMissionCompletion()
        }
    }
    
    @Published var firstSpinCompleted = false {
        didSet { defaults.set(firstSpinCompleted, forKey: "firstSpinCompleted") }
    }
    
    @Published var consecutiveWins = 0 {
        didSet { defaults.set(consecutiveWins, forKey: "consecutiveWins") }
    }
    
    @Published var singleSpinMaxWin = 0 {
        didSet { defaults.set(singleSpinMaxWin, forKey: "singleSpinMaxWin") }
    }
    
    @Published var slotsPlayed = 0 {
        didSet { defaults.set(slotsPlayed, forKey: "slotsPlayed") }
    }
    
    @Published var maxBetCount = 0 {
        didSet { defaults.set(maxBetCount, forKey: "maxBetCount") }
    }
    
    @Published var totalSpins = 0 {
        didSet { defaults.set(totalSpins, forKey: "totalSpins") }
    }
    
    @Published var currentXP: Int = 0 {
        didSet {
            defaults.set(currentXP, forKey: "currentXP")
            checkLevelUp()
        }
    }
    
    @Published var profileImageName: String = "profileImg1" {
        didSet {
            defaults.set(profileImageName, forKey: "profileImageName")
        }
    }
    
    @Published var currentLevel: Int = 1 {
        didSet {
            defaults.set(currentLevel, forKey: "currentLevel")
        }
    }
    
    @Published var minesRevealed: Int = 0 {
        didSet { defaults.set(minesRevealed, forKey: "minesRevealed") }
    }
    
    @Published var coinFlipsWon: Int = 0 {
        didSet { defaults.set(coinFlipsWon, forKey: "coinFlipsWon") }
    }
    
    @Published var crashCashouts5x: Int = 0 {
        didSet { defaults.set(crashCashouts5x, forKey: "crashCashouts5x") }
    }
    
    @Published var totalGamesPlayed: Int = 0 {
        didSet { defaults.set(totalGamesPlayed, forKey: "totalGamesPlayed") }
    }
    
    @Published var maxBetAmount: Int = 0 {
        didSet { defaults.set(maxBetAmount, forKey: "maxBetAmount") }
    }
    
    @Published var maxMultiplierWon: Double = 0 {
        didSet { defaults.set(maxMultiplierWon, forKey: "maxMultiplierWon") }
    }
    
    @Published var fruitSlotsWins: Int = 0 {
        didSet { defaults.set(fruitSlotsWins, forKey: "fruitSlotsWins") }
    }
    
    @Published var classicSlotsWins: Int = 0 {
        didSet { defaults.set(classicSlotsWins, forKey: "classicSlotsWins") }
    }
    
    @Published var goldSlotsWins: Int = 0 {
        didSet { defaults.set(goldSlotsWins, forKey: "goldSlotsWins") }
    }
    
    // Трекеры для achievements и missions
    @Published var totalWins: Int = 0 {
        didSet { defaults.set(totalWins, forKey: "totalWins") }
    }
    
    @Published var totalCoinsWon: Int = 0 {
        didSet { defaults.set(totalCoinsWon, forKey: "totalCoinsWon") }
    }
    
    private init() {
        loadAllData()
    }
    
    // MARK: - Achievements
    private func saveAchievements() {
        if let data = try? JSONEncoder().encode(achievements) {
            defaults.set(data, forKey: achievementsKey)
        }
    }
    
    private func loadAchievements() {
        guard let data = defaults.data(forKey: achievementsKey),
              let savedAchievements = try? JSONDecoder().decode([Missions].self, from: data) else {
            // Дефолтные achievements
            achievements = [
                Missions(image: "ac1", name: "First Spin", desc: "Spin the slots for the first time", goal: 1, currentStep: 0, reward: 500),
                Missions(image: "ac2", name: "Spin Master", desc: "Spin the slots 100 times", goal: 100, currentStep: 0, reward: 5000),
                Missions(image: "ac3", name: "Lucky Winner", desc: "Win 50 times", goal: 50, currentStep: 0, reward: 5000),
                Missions(image: "ac4", name: "High Roller", desc: "Accumulate 100,000 coins", goal: 100000, currentStep: 0, reward: 10000)
            ]
            return
        }
        achievements = savedAchievements
    }
    
    private func checkAchievementCompletion() {
        for i in achievements.indices where achievements[i].isDone && achievements[i].reward > 0 {
            addCoins(achievements[i].reward)
            achievements[i].reward = 0
            print("🎉 Achievement completed: \(achievements[i].name)! +\(achievements[i].reward) coins")
        }
    }
    
    // MARK: - Missions
    private func saveMissions() {
        if let data = try? JSONEncoder().encode(missions) {
            defaults.set(data, forKey: missionsKey)
        }
    }
    
    private func loadMissions() {
        guard let data = defaults.data(forKey: missionsKey),
              let savedMissions = try? JSONDecoder().decode([Missions].self, from: data) else {
            missions = [
                Missions(image: "ms1", name: "Spin Master", desc: "Spin the slots 50 times", goal: 50, currentStep: 0, reward: 1000),
                Missions(image: "ms2", name: "Big winner", desc: "Win 10,000 coins in total", goal: 10000, currentStep: 0, reward: 2000),
                Missions(image: "ms3", name: "Spin Legend", desc: "Spin the slots 1000 times", goal: 1000, currentStep: 0, reward: 5000)
            ]
            return
        }
        missions = savedMissions
    }
    
    private func checkMissionCompletion() {
        for i in missions.indices where missions[i].isDone && missions[i].reward > 0 {
            addCoins(missions[i].reward)
            missions[i].reward = 0
            print("🎉 Mission completed: \(missions[i].name)! +\(missions[i].reward) coins")
        }
    }
    
    enum MissionType {
        case spin, win, coins
    }
    
    func updateMissionProgress(type: MissionType) {
        updateAchievementsProgress(type: type)
        updateMissionsProgress(type: type)
        objectWillChange.send()
    }
    
    private func updateAchievementsProgress(type: MissionType) {
        switch type {
        case .spin:
            for i in achievements.indices where achievements[i].desc.contains("Spin") {
                achievements[i].currentStep = totalSpins
            }
        case .win:
            for i in achievements.indices where achievements[i].name == "Lucky Winner" {
                achievements[i].currentStep = totalWins
            }
        case .coins:
            for i in achievements.indices where achievements[i].name == "High Roller" {
                achievements[i].currentStep = totalCoinsWon
            }
        }
    }
    
    private func updateMissionsProgress(type: MissionType) {
        switch type {
        case .spin:
            for i in missions.indices where missions[i].desc.contains("Spin") {
                missions[i].currentStep = totalSpins
            }
        case .win:
            for i in missions.indices where missions[i].name.contains("winner") {
                missions[i].currentStep = totalWins
            }
        case .coins:
            for i in missions.indices where missions[i].name == "Big winner" {
                missions[i].currentStep = totalCoinsWon
            }
        }
    }
    
    func value<T>(forKey key: String) -> T? {
        defaults.value(forKey: key) as? T
    }
    
    func setValue<T>(_ value: T, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func increment(key: String, by amount: Int = 1) {
        let current = (defaults.integer(forKey: key) + amount)
        defaults.set(current, forKey: key)
        updatePublishedProperty(key: key, value: current)
    }
    
    func updateMax(key: String, newValue: Int) {
        let current = defaults.integer(forKey: key)
        if newValue > current {
            defaults.set(newValue, forKey: key)
            updatePublishedProperty(key: key, value: newValue)
        }
    }
    
    func updateMaxMultiplier(newValue: Double) {
        if newValue > maxMultiplierWon {
            maxMultiplierWon = newValue
        }
    }
    
    private func updatePublishedProperty(key: String, value: Int) {
        switch key {
        case "minesRevealed": minesRevealed = value
        case "coinFlipsWon": coinFlipsWon = value
        case "crashCashouts5x": crashCashouts5x = value
        case "currentLevel": currentLevel = value
        case "totalGamesPlayed": totalGamesPlayed = value
        case "maxBetAmount": maxBetAmount = value
        case "fruitSlotsWins": fruitSlotsWins = value
        case "classicSlotsWins": classicSlotsWins = value
        case "goldSlotsWins": goldSlotsWins = value
        default: break
        }
    }
    
    private func loadAllData() {
        loadAchievements()
        loadMissions()
        firstSpinCompleted = defaults.bool(forKey: "firstSpinCompleted")
        consecutiveWins = defaults.integer(forKey: "consecutiveWins")
        singleSpinMaxWin = defaults.integer(forKey: "singleSpinMaxWin")
        slotsPlayed = defaults.integer(forKey: "slotsPlayed")
        maxBetCount = defaults.integer(forKey: "maxBetCount")
        totalSpins = defaults.integer(forKey: "totalSpins")
        coins = defaults.integer(forKey: "coins")
        
        let savedLevel = defaults.integer(forKey: "currentLevel")
        currentLevel = savedLevel > 0 ? savedLevel : 1
        
        if let savedProfileImg = defaults.string(forKey: "profileImageName") {
            profileImageName = savedProfileImg
        } else {
            profileImageName = "profileImg1"
        }
        
        currentXP = defaults.integer(forKey: "currentXP")
        minesRevealed = defaults.integer(forKey: "minesRevealed")
        coinFlipsWon = defaults.integer(forKey: "coinFlipsWon")
        crashCashouts5x = defaults.integer(forKey: "crashCashouts5x")
        totalGamesPlayed = defaults.integer(forKey: "totalGamesPlayed")
        maxBetAmount = defaults.integer(forKey: "maxBetAmount")
        
        if let multiplier = defaults.value(forKey: "maxMultiplierWon") as? Double {
            maxMultiplierWon = multiplier
        }
        
        fruitSlotsWins = defaults.integer(forKey: "fruitSlotsWins")
        classicSlotsWins = defaults.integer(forKey: "classicSlotsWins")
        goldSlotsWins = defaults.integer(forKey: "goldSlotsWins")
        totalWins = defaults.integer(forKey: "totalWins")
        totalCoinsWon = defaults.integer(forKey: "totalCoinsWon")
    }
    
    // MARK: - Game Actions
    func revealSafeTile() {
        increment(key: "minesRevealed")
    }
    
    func winCoinFlip() {
        increment(key: "coinFlipsWon")
    }
    
    func cashout5x() {
        increment(key: "crashCashouts5x")
    }
    
    func updateLevel(_ level: Int) {
        currentLevel = level
    }
    
    func placeBet(_ amount: Int) {
        updateMax(key: "maxBetAmount", newValue: amount)
    }
    
    func winMultiplier(_ multiplier: Double) {
        updateMaxMultiplier(newValue: multiplier)
    }
    
    func winFruitSlot() {
        increment(key: "fruitSlotsWins")
    }
    
    func winClassicSlot() {
        increment(key: "classicSlotsWins")
    }
    
    func winGoldSlot() {
        increment(key: "goldSlotsWins")
    }
    
    func addXP(_ amount: Int) {
        currentXP += amount
    }
    
    func playGame() {
        addXP(10)
        increment(key: "totalGamesPlayed")
    }
    
    private func checkLevelUp() {
        while currentXP >= currentLevel * 1000 {
            currentLevel += 1
            print("🎉 Level Up! Now level \(currentLevel)")
        }
    }
    
    var xpProgress: Double {
        let xpForCurrentLevel = (currentLevel - 1) * 1000
        let xpNeededForNextLevel = currentLevel * 1000
        let progress = Double(currentXP - xpForCurrentLevel) / Double(xpNeededForNextLevel - xpForCurrentLevel)
        return min(progress, 1.0)
    }
    
    var xpToNextLevel: Int {
        currentLevel * 1000 - currentXP
    }
    
    func completeFirstSpin() {
        if !firstSpinCompleted {
            firstSpinCompleted = true
        }
    }
    
    func addConsecutiveWin() {
        consecutiveWins += 1
    }
    
    func resetConsecutiveWins() {
        consecutiveWins = 0
    }
    
    func updateSingleSpinWin(_ amount: Int) {
        if amount > singleSpinMaxWin {
            singleSpinMaxWin = amount
        }
    }
    
    func playSlotGame() {
        slotsPlayed += 1
        updateMissionProgress(type: .spin)
    }
    
    func placeMaxBet() {
        maxBetCount += 1
    }
    
    func completeSpin() {
        totalSpins += 1
        updateMissionProgress(type: .spin)
    }
    
    func recordWin(_ winAmount: Int) {
        totalWins += 1
        totalCoinsWon += winAmount
        updateMissionProgress(type: .win)
        updateMissionProgress(type: .coins)
    }
    
    func resetAllData() {
        coins = 0
        firstSpinCompleted = false
        consecutiveWins = 0
        singleSpinMaxWin = 0
        slotsPlayed = 0
        maxBetCount = 0
        totalSpins = 0
        currentXP = 0
        profileImageName = "profileImg1"
        currentLevel = 1
        minesRevealed = 0
        coinFlipsWon = 0
        crashCashouts5x = 0
        totalGamesPlayed = 0
        maxBetAmount = 0
        maxMultiplierWon = 0
        fruitSlotsWins = 0
        classicSlotsWins = 0
        goldSlotsWins = 0
        totalWins = 0
        totalCoinsWon = 0
        
        addCoins(5000)
        
        let keysToRemove = [
            "coins", "firstSpinCompleted", "consecutiveWins", "singleSpinMaxWin",
            "slotsPlayed", "maxBetCount", "totalSpins", "currentXP",
            "profileImageName", "currentLevel", "minesRevealed", "coinFlipsWon",
            "crashCashouts5x", "totalGamesPlayed", "maxBetAmount", "maxMultiplierWon",
            "fruitSlotsWins", "classicSlotsWins", "goldSlotsWins", "totalWins",
            "totalCoinsWon"
        ]
        
        for key in keysToRemove {
            defaults.removeObject(forKey: key)
        }
        
        defaults.removeObject(forKey: achievementsKey)
        defaults.removeObject(forKey: missionsKey)
    }
}

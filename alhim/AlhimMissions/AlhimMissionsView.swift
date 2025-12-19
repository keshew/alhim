import SwiftUI

struct Missions: Identifiable, Codable {
    var id = UUID()
    var image: String
    var name: String
    var desc: String
    var goal: Int
    var currentStep: Int
    var reward: Int
    
    var isDone: Bool {
        currentStep >= goal
    }
}


struct AlhimMissionsView: View {
    @StateObject var alhimMissionsModel =  AlhimMissionsViewModel()
    @State  var coin = UserDefaultsManager.shared.coins
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var manager = UserDefaultsManager.shared
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                
                Color.clear
                    .overlay(
                        ZStack {
                            Image("bg")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            LinearGradient(colors: [Color(red: 21/255, green: 51/255, blue: 62/255),
                                                    Color(red: 63/255, green: 22/255, blue: 105/255)], startPoint: .leading, endPoint: .trailing).opacity(0.4)
                        }
                    )
                    .clipped()
                    .ignoresSafeArea()
                
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [Color(red: 108/255, green: 22/255, blue: 191/255)], startPoint: .leading, endPoint: .trailing)
                        .frame(height: 70)
                    
                    Rectangle()
                        .foregroundStyle(Color(red: 239/255, green: 57/255, blue: 209/255))
                        .frame(height: 2)
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    
                    VStack {
                        HStack(spacing: 10) {
                            Spacer()
                            
                            Image("pr3")
                                .resizable()
                                .frame(width: 18, height: 18)
                            
                            Text("Missions")
                                .font(.custom("Poppins-Bold", size: 14))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                Image("backBtn")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }
                            .hidden()
                        }
                        .shadow(color: Color(red: 255/255, green: 233/255, blue: 64/255).opacity(0.5), radius: 5)
                        .padding(.top, UIScreen.main.bounds.width > 1000 ? -5 : 15)
                        
                        ScrollView(showsIndicators: false) {
                            HStack {
                                Spacer()
                                Color.clear.frame(width: 0)
                                
                                VStack(spacing: 10) {
                                    VStack {
                                        Text("Complete Missions")
                                            .font(.custom("Poppins-Bold", size: 24))
                                            .foregroundStyle(Color.white)
                                        
                                        
                                        Text("Earn rewards by completing daily and weekly missions")
                                            .font(.custom("Poppins-Regular", size: 11))
                                            .foregroundStyle(Color.white.opacity(0.6))
                                    }
                                    .padding(.top, 10)
                                    
                                    VStack(spacing: 15) {
                                        ForEach(manager.missions, id: \.id) { mis in
                                            Rectangle()
                                                .fill(Color(red: 107/255, green: 21/255, blue: 193/255).opacity(0.9))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color(red: 239/255, green: 57/255, blue: 209/255), lineWidth: 5)
                                                        .overlay {
                                                            HStack(alignment: .top, spacing: 5) {
                                                                Image(mis.image)
                                                                    .resizable()
                                                                    .frame(width: 64, height: 64)
                                                                
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    VStack(alignment: .leading, spacing: 5) {
                                                                        Text(mis.name)
                                                                            .font(.custom("Poppins-Bold", size: 16))
                                                                            .foregroundStyle(Color.white)
                                                                        
                                                                        Text(mis.desc)
                                                                            .font(.custom("Poppins-Light", size: 12))
                                                                            .foregroundStyle(Color.white)
                                                                    }
                                                                    
                                                                    VStack(spacing: 5) {
                                                                        let progress = Double(mis.currentStep) / Double(mis.goal)
                                                                        
                                                                        HStack {
                                                                            Text("\(mis.currentStep) / \(mis.goal)")
                                                                                .font(.custom("Poppins-Medium", size: 10))
                                                                                .foregroundStyle(.white.opacity(0.6))
                                                                            
                                                                            Spacer()
                                                                            
                                                                            Text("\(String(format: "%.0f", progress * 100))%")
                                                                                .font(.custom("Poppins-Medium", size: 12))
                                                                                .foregroundStyle(.white.opacity(0.6))
                                                                        }
                                                                        
                                                                        GeometryReader { geometry in
                                                                            ZStack(alignment: .leading) {
                                                                                Rectangle()
                                                                                    .fill(Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.3))
                                                                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                                                                
                                                                                Rectangle()
                                                                                    .fill(Color(red: 239/255, green: 57/255, blue: 209/255))
                                                                                    .frame(width: geometry.size.width * progress, height: geometry.size.height)
                                                                            }
                                                                            .cornerRadius(10)
                                                                        }
                                                                        .frame(height: 7)
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Reward: \(mis.reward) coins")
                                                                            .font(.custom("Poppins-Bold", size: 14))
                                                                            .foregroundStyle(Color(red: 238/255, green: 189/255, blue: 43/255))
                                                                        
                                                                        Spacer()
                                                                    }
                                                                }
                                                                .padding(.trailing)
                                                            }
                                                        }
                                                }
                                                .frame(width: 550, height: 130)
                                                .cornerRadius(12)
                                                .shadow(color: Color(red: 239/255, green: 57/255, blue: 209/255), radius: 10)
                                        }
                                    }
                                }
                                
//                                if UIScreen.main.bounds.width > 1000 {
                                    Spacer()
                                    Color.clear.frame(width: 0)
//                                }
                            }
                        }
                        .padding(.top, 7)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                self.coin = UserDefaultsManager.shared.coins
            }
        }
    }
}

#Preview {
    AlhimMissionsView()
}


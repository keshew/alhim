import SwiftUI

struct AlhimAchievView: View {
    @StateObject var AlhimAchievModel =  AlhimAchievViewModel()
    @State  var coin = UserDefaultsManager.shared.coins
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var manager = UserDefaultsManager.shared
    
    private var achievementsProgress: Double {
        let completed = manager.achievements.filter { $0.isDone }.count
        return Double(completed) / Double(manager.achievements.count)
    }
    
    private var progressPercentage: String {
        String(format: "%.0f%%", achievementsProgress * 100)
    }
    
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
                            
                            Text("Achievements")
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
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 238/255, green: 189/255, blue: 43/255),
                                                                      Color(red: 196/255, green: 127/255, blue: 34/255)], startPoint: .leading, endPoint: .trailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color(red: 238/255, green: 183/255, blue: 49/255), lineWidth: 5)
                                                .overlay {
                                                    VStack(spacing: 6) {
                                                        Image("achievMa")
                                                            .resizable()
                                                            .frame(width: 64, height: 64)
                                                        
                                                        Text("1/8")
                                                            .font(.custom("Poppins-Bold", size: 16))
                                                            .foregroundStyle(Color.white)
                                                        
                                                        Text("Achievements Unlocked")
                                                            .font(.custom("Poppins-Light", size: 12))
                                                            .foregroundStyle(Color.white)
                                                        
                                                        GeometryReader { geometry in
                                                            ZStack(alignment: .leading) {
                                                                Rectangle()
                                                                    .fill(Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.3))
                                                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                                                
                                                                Rectangle()
                                                                    .fill(Color(red: 239/255, green: 57/255, blue: 209/255))
                                                                    .frame(width: geometry.size.width - 100, height: geometry.size.height)
                                                            }
                                                            .cornerRadius(10)
                                                        }
                                                        .frame(height: 10)
                                                        .padding(.horizontal)
                                                        
                                                        Text("13% Complete")
                                                            .font(.custom("Poppins-Light", size: 12))
                                                            .foregroundStyle(Color.white)
                                                    }
                                                }
                                        }
                                        .frame(width: 540, height: 170)
                                        .cornerRadius(16)
                                    .padding(.top, 10)
                                    
                                    LazyVGrid(columns: [GridItem(.flexible(minimum: 270, maximum: 270)),
                                                        GridItem(.flexible(minimum: 270, maximum: 270))], spacing: 10) {
                                        ForEach(manager.achievements, id: \.id) { mis in
                                            Rectangle()
                                                .fill(Color(red: 107/255, green: 21/255, blue: 193/255).opacity(0.9))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(mis.isDone ? Color(red: 238/255, green: 189/255, blue: 43/255) : Color(red: 239/255, green: 57/255, blue: 209/255), lineWidth: 5)
                                                        .overlay {
                                                            HStack(alignment: .top, spacing: 5) {
                                                                Image(mis.image)
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 40, height: 40)
                                                                
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    VStack(alignment: .leading, spacing: 5) {
                                                                        Text(mis.name)
                                                                            .font(.custom("Poppins-Bold", size: 16))
                                                                            .foregroundStyle(Color.white)
                                                                        
                                                                        Text(mis.desc)
                                                                            .font(.custom("Poppins-Light", size: 12))
                                                                            .foregroundStyle(Color.white)
                                                                    }
                                                                    
                                                                    if !mis.isDone {
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
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Image("pr3")
                                                                            .resizable()
                                                                            .frame(width: 16, height: 16)
                                                                        
                                                                        Text("\(mis.reward) coins")
                                                                            .font(.custom("Poppins-Bold", size: 14))
                                                                            .foregroundStyle(Color(red: 238/255, green: 189/255, blue: 43/255))
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Image(mis.isDone ? "done" : "locked")
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 24, height: 24)
                                                                    }
                                                                }
                                                                .padding(.trailing)
                                                            }
                                                            .padding(.leading)
                                                        }
                                                }
                                                .frame(width: 270, height: 140)
                                                .cornerRadius(12)
                                                .shadow(color: Color(red: 238/255, green: 189/255, blue: 43/255), radius: mis.isDone ? 10 : 0)
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
    AlhimAchievView()
}


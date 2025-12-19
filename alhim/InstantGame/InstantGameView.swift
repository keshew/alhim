import SwiftUI

struct InstantGameView: View {
    @StateObject var InstantGameModel =  InstantGameViewModel()
    @State var showAlert = false
    @State var isSlot1 = false
    @State var isSlot2 = false
    @State var isSlot3 = false
    @State var isSlot4 = false
    @State var isSlot5 = false
    @State var isSettings = false
    @State var isProfile = false
    @State  var coin = UserDefaultsManager.shared.coins
    @Binding var tab:  CustomTabBar.TabType
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
                            
                            HStack {
                                Image("coins")
                                    .resizable()
                                    .frame(width: 24, height: 31)
                                
                                Text("\(coin)")
                                    .font(.custom("Poppins-Bold", size: 18))
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background(LinearGradient(colors: [Color(red: 238/255, green: 189/255, blue: 43/255),
                                                                Color(red: 196/255, green: 127/255, blue: 34/255)], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(22)
                            .overlay {
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color(red: 238/255, green: 189/255, blue: 43/255), lineWidth: 1)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 5) {
                                Image("star")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                
                                Spacer()
                                
                                VStack(spacing: 3) {
                                    let progress = manager.xpProgress
                                    HStack {
                                        Text("Level \(manager.currentLevel)")
                                            .font(.custom("Poppins-Bold", size: 14))
                                            .foregroundStyle(.white)
                                        
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
                                    .frame(width: 120, height: 5)
                                }
                                .frame(width: 120, height: 25)
                            }
                            .frame(width: 110, height: 28)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                            .background(Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.2))
                            .cornerRadius(22)
                            .overlay {
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color(red: 239/255, green: 57/255, blue: 209/255), lineWidth: 1)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    isProfile = true
                                }) {
                                    Image("profile")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                                
                                Button(action: {
                                    isSettings = true
                                }) {
                                    Image("settings")
                                        .resizable()
                                        .frame(width: 44, height: 44)
                                }
                            }
                            
                        }
                        .shadow(color: Color(red: 255/255, green: 233/255, blue: 64/255).opacity(0.5), radius: 5)
                        .padding(.top, UIScreen.main.bounds.width > 1000 ? -5 : 15)
                        
                        ScrollView(showsIndicators: false) {
                            HStack {
                                Spacer()
                                Color.clear.frame(width: 0)
                                
                                VStack(spacing: 10) {
                                    HStack {
                                        Image("instant")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .offset(y: 5)
                                        Text("Instant Games")
                                            .font(.custom("Poppins-Bold", size: 24))
                                            .foregroundStyle(Color.white)
                                            .padding(.top, 10)
                                    }
                                    
                                    LazyVGrid(columns: [GridItem(.flexible(minimum: 200, maximum: 210)),
                                                        GridItem(.flexible(minimum: 200, maximum: 210)),
                                                        GridItem(.flexible(minimum: 200, maximum: 210))]) {
                                        ForEach(0..<5, id: \.self) { index in
                                            Button(action: {
                                                switch index {
                                                case 0: isSlot1 = true
                                                case 1: isSlot2 = true
                                                case 2: isSlot3 = true
                                                case 3: isSlot4 = true
                                                case 4: isSlot5 = true
                                                default:
                                                    isSlot1 = true
                                                }
                                            }) {
                                                Image("instant\(index + 1)")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 200, height: 140)
                                            }
                                        }
                                    }
                                    
                                    Button(action: {
                                        tab = .Achiev
                                    }) {
                                        Rectangle()
                                            .fill(LinearGradient(colors: [Color(red: 238/255, green: 189/255, blue: 43/255),
                                                                          Color(red: 196/255, green: 127/255, blue: 34/255)], startPoint: .leading, endPoint: .trailing))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color(red: 238/255, green: 189/255, blue: 43/255), lineWidth: 3)
                                                    .overlay {
                                                        HStack {
                                                            Image("achiev")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 14, height: 14)
                                                            
                                                            Text("View Achievements (1/8)")
                                                                .font(.custom("Poppins-Bold", size: 15))
                                                                .foregroundStyle(Color.white)
                                                        }
                                                    }
                                            }
                                            .frame(width: 580, height: 50)
                                            .cornerRadius(16)
                                            .shadow(color: Color(red: 238/255, green: 189/255, blue: 43/255), radius: 5)
                                    }
                                }
                                
                                if UIScreen.main.bounds.width > 1000 {
                                    Spacer()
                                    Color.clear.frame(width: 0)
                                }
                            }
                        }
                        .padding(.top, 7)
                    }
                    .padding(.trailing)
                }
            }
            
            if isSettings {
                AlhimSettingsView(show: $isSettings)
                    .ignoresSafeArea()
            }
            
            if isProfile {
                AlhimProfileView(show: $isProfile)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                self.coin = UserDefaultsManager.shared.coins
            }
        }
        .fullScreenCover(isPresented: $isSlot1) {
            CoinFlipView()
        }
        .fullScreenCover(isPresented: $isSlot2) {
            LuckyDiceView()
        }
        .fullScreenCover(isPresented: $isSlot3) {
            HiLoView()
        }
        .fullScreenCover(isPresented: $isSlot4) {
            FortuneView()
        }
        .fullScreenCover(isPresented: $isSlot5) {
            RPSView()
        }
    }
}

#Preview {
    InstantGameView(tab: .constant(CustomTabBar.TabType.Instant))
}


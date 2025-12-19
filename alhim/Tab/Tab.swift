import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: CustomTabBar.TabType = .Home
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Home {
                    AlhimMenuView()
                } else if selectedTab == .Instant {
                    InstantGameView(tab: $selectedTab)
                } else if selectedTab == .Achiev {
                    AlhimAchievView()
                } else if selectedTab == .Missions {
                    AlhimMissionsView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    @StateObject private var manager = UserDefaultsManager.shared
    var profileImg: String { manager.profileImageName }
    enum TabType: Int {
        case Home
        case Instant
        case Achiev
        case Missions
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 108/255, green: 22/255, blue: 191/255)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 140)
                    .edgesIgnoringSafeArea(.vertical)
            }
            
            VStack {
                Image("tabimg")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .padding(.top, 17.5)
                
                VStack(alignment: .leading, spacing: 15) {
                    TabBarItem(imageName: "tab1", tab: .Home, selectedTab: $selectedTab)
                    TabBarItem(imageName: "tab2", tab: .Instant, selectedTab: $selectedTab)
                    TabBarItem(imageName: "tab3", tab: .Achiev, selectedTab: $selectedTab)
                    TabBarItem(imageName: "tab4", tab: .Missions, selectedTab: $selectedTab)
                }
                .padding(.horizontal, 10)
                .frame(height: 170)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            if selectedTab == tab {
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 239/255, green: 57/255, blue: 209/255),
                                                  Color(red: 212/255, green: 17/255, blue: 180/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 239/255, green: 57/255, blue: 209/255), lineWidth: 2)
                            .overlay {
                                HStack(spacing: 6) {
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                    
                                    Text("\(tab)")
                                        .font(.custom("Poppins-Bold", size: 12))
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                }
                                .padding(.leading , 10)
                            }
                    }
                    .frame(width: 100, height: 30)
                    .cornerRadius(10)
                    .shadow(color: Color(red: 239/255, green: 57/255, blue: 209/255), radius: 10)
            } else {
                HStack(spacing: 6) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                    
                    Text("\(tab)")
                        .font(.custom("Poppins-Bold", size: 12))
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .frame(width: 100, height: 30)
                .padding(.leading , 10)
            }
        }
    }
}

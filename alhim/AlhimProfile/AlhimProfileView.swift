import SwiftUI

struct AlhimProfileView: View {
    @StateObject var alhimProfileModel =  AlhimProfileViewModel()
    @Binding var show: Bool
    @State  var coin = UserDefaultsManager.shared.coins
    @ObservedObject var manager = UserDefaultsManager.shared
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            
            Rectangle()
                .fill(Color(red: 107/255, green: 21/255, blue: 193/255))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 239/255, green: 57/255, blue: 209/255), lineWidth: 5)
                        .overlay {
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Player Profile")
                                        .font(.custom("Poppins-Bold", size: 18))
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        show.toggle()
                                    }) {
                                        Image("close")
                                            .resizable()
                                            .frame(width: 32, height: 36)
                                    }
                                }
                                
                                VStack {
                                    Image("profileImg")
                                        .resizable()
                                        .frame(width: 42, height: 42)
                                    
                                    Text("Player")
                                        .font(.custom("Poppins-Bold", size: 12))
                                        .foregroundStyle(.white)
                                    
                                    Text("Casino Enthusiast")
                                        .font(.custom("Poppins-Regular", size: 8))
                                        .foregroundStyle(.white)
                                }
                                
                                Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.3)
                                    .frame(height: 1)
                                    .padding(.top, 10)
                                
                                VStack {
                                    Rectangle()
                                        .fill(Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.1))
                                        .overlay {
                                            HStack {
                                                Image("pr1")
                                                    .resizable()
                                                    .frame(width: 16, height: 16)
                                                
                                                Text("Total Coins")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                                
                                                Spacer()
                                                
                                                Text("\(coin)")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(Color(red: 238/255, green: 189/255, blue: 43/255))
                                            }
                                            .padding(.horizontal)
                                        }
                                        .frame(height: 40)
                                        .cornerRadius(12)
                                    
                                    Rectangle()
                                        .fill(Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.1))
                                        .overlay {
                                            HStack {
                                                Image("star")
                                                    .resizable()
                                                    .frame(width: 16, height: 16)
                                                
                                                Text("Level")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                                
                                                Spacer()
                                                
                                                Text("\(manager.currentLevel)")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                            }
                                            .padding(.horizontal)
                                        }
                                        .frame(height: 40)
                                        .cornerRadius(12)
                                    
                                    Rectangle()
                                        .fill(Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.1))
                                        .overlay {
                                            HStack {
                                                let progress = manager.xpProgress
                                                
                                                Image("pr3")
                                                    .resizable()
                                                    .frame(width: 16, height: 16)
                                                
                                                Text("XP Progress")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                                
                                                Spacer()
                                                
                                                Text("\(String(format: "%.0f", progress * 100))/1000")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                            }
                                            .padding(.horizontal)
                                        }
                                        .frame(height: 40)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                }
                .frame(width: 300, height: 320)
                .cornerRadius(12)
        }
    }
}

#Preview {
    AlhimProfileView(show: .constant(true))
}


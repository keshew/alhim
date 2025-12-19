import SwiftUI

struct CoinFlipView: View {
    @StateObject var viewModel =  CoinFlipViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    Color.clear
                        .overlay(
                            ZStack {
                                Image("coinbg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                                LinearGradient(colors: [Color(red: 21/255, green: 51/255, blue: 62/255),
                                                        Color(red: 63/255, green: 22/255, blue: 105/255)], startPoint: .leading, endPoint: .trailing).opacity(0.4)
                            }
                        )
                        .clipped()
                        .ignoresSafeArea()
                    
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [Color(red: 196/255, green: 127/255, blue: 34/255)], startPoint: .leading, endPoint: .trailing)
                            .frame(height: 70)
                        
                        Rectangle()
                            .foregroundStyle(Color(red: 238/255, green: 189/255, blue: 43/255))
                            .frame(height: 2)
                    }
                }
                
                ZStack(alignment: .top) {
                    LinearGradient(colors: [Color(red: 196/255, green: 127/255, blue: 34/255)], startPoint: .leading, endPoint: .trailing)
                        .frame(height: UIScreen.main.bounds.width > 1000 ? 90 : 80)
                    
                    Rectangle()
                        .foregroundStyle(Color(red: 238/255, green: 189/255, blue: 43/255))
                        .frame(height: 2)
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        HStack(spacing: 10) {
                            Button(action: {
                                NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Rectangle()
                                    .fill(Color(red: 238/255, green: 189/255, blue: 43/255))
                                    .overlay {
                                        Image(systemName: "arrow.left")
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 40, height: 36)
                                    .cornerRadius(26)
                                
                            }
                          
                            Spacer()
                            
                            Text("Coin Flip")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            HStack {
                                Image("coins")
                                    .resizable()
                                    .frame(width: 24, height: 31)
                                
                                Text("\(viewModel.coin)")
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
                        }
                        .shadow(color: Color(red: 255/255, green: 233/255, blue: 64/255).opacity(0.5), radius: 5)
                        .padding(.top, UIScreen.main.bounds.width > 1000 ? -5 : 15)
                        .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            Rectangle()
                                .fill(Color(red: 196/255, green: 127/255, blue: 34/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(red: 238/255, green: 189/255, blue: 43/255), lineWidth: 5)
                                        .overlay {
                                            VStack {
                                                Text("Choose Your Side")
                                                    .font(.custom("Poppins-Bold", size: 12))
                                                    .foregroundStyle(.white)
                                                
                                                HStack {
                                                    Button(action: {
                                                        viewModel.isTail = false
                                                    }) {
                                                        ZStack {
                                                            Circle()
                                                                .fill(Color(red: 238/255, green: 189/255, blue: 43/255))
                                                                .frame(width: 64, height: 64)
                                                            
                                                            Circle()
                                                                .fill(Color(red: 192/255, green: 145/255, blue: 21/255))
                                                                .frame(width: 61, height: 61)
                                                            
                                                            Image("head")
                                                                .resizable()
                                                                .frame(width: 40, height: 40)
                                                        }
                                                    }
                                                    .shadow(color: Color(red: 238/255, green: 189/255, blue: 43/255), radius: !viewModel.isTail ? 10 : 0)
                                                    
                                                    Button(action: {
                                                        viewModel.isTail = true
                                                    }) {
                                                        ZStack {
                                                            Circle()
                                                                .fill(Color(red: 238/255, green: 189/255, blue: 43/255))
                                                                .frame(width: 64, height: 64)
                                                            
                                                            Circle()
                                                                .fill(Color(red: 192/255, green: 145/255, blue: 21/255))
                                                                .frame(width: 61, height: 61)
                                                            
                                                            Image("trail")
                                                                .resizable()
                                                                .frame(width: 40, height: 40)
                                                        }
                                                    }
                                                    .shadow(color: Color(red: 238/255, green: 189/255, blue: 43/255), radius: viewModel.isTail ? 10 : 0)
                                                }
                                                
                                                ZStack {
                                                    Circle()
                                                        .fill(Color(red: 238/255, green: 189/255, blue: 43/255))
                                                        .frame(width: 74, height: 74)
                                                    
                                                    Circle()
                                                        .fill(Color(red: 192/255, green: 145/255, blue: 21/255))
                                                        .frame(width: 71, height: 71)
                                                    
                                                    if viewModel.showQuestionMark {
                                                        Text("?")
                                                            .font(.custom("Poppins-Bold", size: 32))
                                                            .foregroundStyle(.white)
                                                    } else if viewModel.isTail {
                                                        Image("trail")
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                    } else {
                                                        Image("head")
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                    }
                                                }
                                                .rotation3DEffect(
                                                    .degrees(Double(viewModel.rotationStep) * 360.0 / 2),
                                                    axis: (x: 0, y: 1, z: 0)
                                                )
                                                .animation(.easeInOut(duration: 0.3), value: viewModel.isTail)
                                                .shadow(color: Color(red: 238/255, green: 189/255, blue: 43/255), radius: 10)
                                            }
                                        }
                                }
                                .frame(width: 250, height: 220)
                                .cornerRadius(12)
                            
                            Spacer()
                            
                            HStack {
                                HStack(spacing: 20) {
                                    Button(action: {
                                        if viewModel.bet >= 100 {
                                            viewModel.bet -= 50
                                        }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 212/255, green: 54/255, blue: 226/255))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color(red: 236/255, green: 152/255, blue: 21/255).opacity(0.7), lineWidth: 0)
                                                    .overlay {
                                                        Text("-")
                                                            .font(.custom("Poppins-Bold", size: 20))
                                                            .foregroundStyle(.white)
                                                    }
                                            }
                                            .frame(width: 30, height: 30)
                                            .cornerRadius(8)
                                    }
                                    .shadow(color: Color(red: 212/255, green: 54/255, blue: 226/255), radius: 10)
                                    
                                    Rectangle()
                                        .fill(Color.black.opacity(0.4))
                                        .frame(width: 90, height: 50)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.white, lineWidth: 2)
                                                .overlay {
                                                    VStack(spacing: -3) {
                                                        Text("BET")
                                                            .font(.custom("Poppins-Bold", size: 16))
                                                            .foregroundStyle(Color(red: 251/255, green: 191/255, blue: 36/255))
                                                        
                                                        Text("\(viewModel.bet)")
                                                            .font(.custom("Poppins-Bold", size: 16))
                                                            .foregroundStyle(.white)
                                                    }
                                                }
                                        }
                                        .cornerRadius(12)
                                    
                                    Button(action: {
                                        if (viewModel.bet + 50) <= viewModel.coin {
                                            viewModel.bet += 50
                                        }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 53/255, green: 226/255, blue: 54/255))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color(red: 236/255, green: 152/255, blue: 21/255).opacity(0.7), lineWidth: 0)
                                                    .overlay {
                                                        Text("+")
                                                            .font(.custom("Poppins-Bold", size: 20))
                                                            .foregroundStyle(.white)
                                                    }
                                            }
                                            .frame(width: 30, height: 30)
                                            .cornerRadius(8)
                                    }
                                    .shadow(color: Color(red: 236/255, green: 152/255, blue: 21/255), radius: 10)
                                }
                                
                                Spacer()
                                
                                Rectangle()
                                    .fill(Color.black.opacity(0.4))
                                    .frame(width: 130, height: 50)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.white, lineWidth: 2)
                                            .overlay {
                                                VStack(spacing: -3) {
                                                    Text("LAST WIN")
                                                        .font(.custom("Poppins-Bold", size: 16))
                                                        .foregroundStyle(Color(red: 251/255, green: 191/255, blue: 36/255))
                                                    
                                                    Text(viewModel.lastWin > 0 ? "\(viewModel.lastWin)" : "0")
                                                        .font(.custom("Poppins-Bold", size: 16))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                    }
                                    .cornerRadius(12)
                                
                                Spacer()
                                
                                VStack(spacing: 3) {
                                    Button(action: {
                                        withAnimation {
                                            viewModel.startFlip(userChoice: viewModel.isTail)
                                           }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 53/255, green: 226/255, blue: 54/255))
                                            .frame(width: 130, height: 25)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(Color.white, lineWidth: 2)
                                                    .overlay {
                                                        VStack(spacing: -3) {
                                                            Text("SPIN")
                                                                .font(.custom("Poppins-Bold", size: 14))
                                                                .foregroundStyle(Color.white)
                                                        }
                                                    }
                                            }
                                            .cornerRadius(6)
                                    }
                                    
                                    Button(action: {
                                        viewModel.maxBetAction()
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 255/255, green: 0/255, blue: 4/255))
                                            .frame(width: 130, height: 25)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(Color.white, lineWidth: 2)
                                                    .overlay {
                                                        VStack(spacing: -3) {
                                                            Text("MAX BET")
                                                                .font(.custom("Poppins-Bold", size: 14))
                                                                .foregroundStyle(Color.white)
                                                        }
                                                    }
                                            }
                                            .cornerRadius(6)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 15)
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    CoinFlipView()
}


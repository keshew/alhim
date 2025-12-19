import SwiftUI

struct RPSView: View {
    @StateObject var viewModel =  RPSViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    Color.clear
                        .overlay(
                            ZStack {
                                Image("rpsBg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                                LinearGradient(colors: [Color(red: 21/255, green: 51/255, blue: 62/255),
                                                        Color(red: 63/255, green: 22/255, blue: 105/255)], startPoint: .leading, endPoint: .trailing).opacity(0.4)
                            }
                        )
                        .clipped()
                        .ignoresSafeArea()
                    
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [Color(red: 187/255, green: 33/255, blue: 195/255)], startPoint: .leading, endPoint: .trailing)
                            .frame(height: 70)
                        
                        Rectangle()
                            .foregroundStyle(Color(red: 238/255, green: 43/255, blue: 202/255))
                            .frame(height: 2)
                    }
                }
                
                ZStack(alignment: .top) {
                    LinearGradient(colors: [Color(red: 187/255, green: 33/255, blue: 195/255)], startPoint: .leading, endPoint: .trailing)
                        .frame(height: UIScreen.main.bounds.width > 1000 ? 90 : 80)
                    
                    Rectangle()
                        .foregroundStyle(Color(red: 238/255, green: 43/255, blue: 202/255))
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
                                    .fill(Color(red: 238/255, green: 43/255, blue: 202/255))
                                    .overlay {
                                        Image(systemName: "arrow.left")
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 40, height: 36)
                                    .cornerRadius(26)
                                
                            }
                          
                            Spacer()
                            
                            Text("Rock Paper Scissors")
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
                            .background(LinearGradient(colors: [Color(red: 238/255, green: 43/255, blue: 202/255),
                                                                Color(red: 187/255, green: 33/255, blue: 195/255)], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(22)
                            .overlay {
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color(red: 228/255, green: 43/255, blue: 238/255), lineWidth: 1)
                            }
                        }
                        .shadow(color: Color(red: 255/255, green: 233/255, blue: 64/255).opacity(0.5), radius: 5)
                        .padding(.top, UIScreen.main.bounds.width > 1000 ? -5 : 15)
                        .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            Spacer()
                            
                            ZStack {
                                HStack(spacing: 40) {
                                    ForEach(RPSViewModel.RPSChoice.allCases, id: \.self) { choice in
                                        Button(action: {
                                            viewModel.selectChoice(choice)
                                        }) {
                                            Rectangle()
                                                .fill(
                                                    viewModel.playerChoice == choice && !viewModel.isFlipping ?
                                                    Color(red: 239/255, green: 57/255, blue: 209/255) :
                                                    Color(red: 110/255, green: 48/255, blue: 193/255)
                                                )
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(
                                                            viewModel.playerChoice == choice && !viewModel.isFlipping ?
                                                            Color(red: 239/255, green: 57/255, blue: 209/255) :
                                                            Color(red: 239/255, green: 57/255, blue: 209/255),
                                                            lineWidth: 5
                                                        )
                                                        .overlay {
                                                            VStack {
                                                                Image(choice.rawValue)
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 80, height: 80)
                                                                
                                                                Text(choice.rawValue.capitalized)
                                                                    .font(.custom("Poppins-Bold", size: 20))
                                                                    .foregroundStyle(.white)
                                                            }
                                                        }
                                                }
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(12)
                                                .shadow(
                                                    color: (viewModel.playerChoice == choice && !viewModel.isFlipping) ?
                                                    Color.cyan.opacity(0.6) : .clear,
                                                    radius: (viewModel.playerChoice == choice && !viewModel.isFlipping) ? 15 : 0
                                                )
                                                .offset(y: viewModel.playerChoice == choice ? 10 : 0)
                                                .blur(radius: (viewModel.showComputerChoice && viewModel.computerChoice != choice) ? 8 : 0)
                                        }
                                        .disabled(viewModel.isFlipping)
                                    }
                                }
                            }
                            
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
                                            viewModel.startGame()
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
                                    .disabled(viewModel.isFlipping || viewModel.playerChoice == nil)

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
    RPSView()
}


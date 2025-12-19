import SwiftUI

struct FortuneView: View {
    @StateObject var viewModel =  FortuneViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    Color.clear
                        .overlay(
                            ZStack {
                                Image("wheelbg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                                LinearGradient(colors: [Color(red: 21/255, green: 51/255, blue: 62/255),
                                                        Color(red: 63/255, green: 22/255, blue: 105/255)], startPoint: .leading, endPoint: .trailing).opacity(0.4)
                            }
                        )
                        .clipped()
                        .ignoresSafeArea()
                    
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [Color(red: 15/255, green: 192/255, blue: 212/255)], startPoint: .leading, endPoint: .trailing)
                            .frame(height: 70)
                        
                        Rectangle()
                            .foregroundStyle(Color(red: 58/255, green: 109/255, blue: 239/255))
                            .frame(height: 2)
                    }
                }
                
                ZStack(alignment: .top) {
                    LinearGradient(colors: [Color(red: 15/255, green: 192/255, blue: 212/255)], startPoint: .leading, endPoint: .trailing)
                        .frame(height: UIScreen.main.bounds.width > 1000 ? 90 : 80)
                    
                    Rectangle()
                        .foregroundStyle(Color(red: 58/255, green: 109/255, blue: 239/255))
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
                                    .fill(Color(red: 15/255, green: 192/255, blue: 212/255))
                                    .overlay {
                                        Image(systemName: "arrow.left")
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 40, height: 36)
                                    .cornerRadius(26)
                                
                            }
                          
                            Spacer()
                            
                            Text("Wheel of Fortune")
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
                            .background(LinearGradient(colors: [Color(red: 15/255, green: 192/255, blue: 212/255),
                                                                Color(red: 34/255, green: 184/255, blue: 195/255)], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(22)
                            .overlay {
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color(red: 58/255, green: 109/255, blue: 239/255), lineWidth: 1)
                            }
                        }
                        .shadow(color: Color(red: 255/255, green: 233/255, blue: 64/255).opacity(0.5), radius: 5)
                        .padding(.top, UIScreen.main.bounds.width > 1000 ? -5 : 15)
                        .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            Spacer()
                            
                            ZStack {
                                ZStack {
                                    Circle()
                                        .stroke(lineWidth: 7)
                                        .foregroundColor(Color(red: 255/255, green: 215/255, blue: 0/255))
                                    
                                    Circle()
                                        .stroke(lineWidth: 10)
                                        .foregroundColor(.clear)
                                    
                                    ForEach(viewModel.segments.indices, id: \.self) { i in
                                        let segmentCount = viewModel.segments.count
                                        let segmentAngle = 360.0 / Double(segmentCount)
                                        let midAngle = Double(i) * segmentAngle + segmentAngle / 2 - 90
                                        
                                        SectorShape(
                                            startAngle: Angle(degrees: Double(i) * segmentAngle),
                                            endAngle: Angle(degrees: Double(i + 1) * segmentAngle)
                                        )
                                        .fill(viewModel.segments[i].color)
                                        .shadow(color: viewModel.selectedSegmentIndex == i ? Color.yellow.opacity(0.8) : Color.clear,
                                                radius: viewModel.selectedSegmentIndex == i ? 15 : 0, x: 0, y: 0)
                                        .overlay(
                                            Text(viewModel.segments[i].title)
                                                .font(.custom("Poppins-Bold", size: 14))
                                                .foregroundStyle(Color.white)
                                                .rotationEffect(Angle(degrees: midAngle + viewModel.rotationDegree))
                                                .position(
                                                    x: 75 + 50 * CGFloat(cos(midAngle * .pi / 180)),
                                                    y: 75 + 50 * CGFloat(sin(midAngle * .pi / 180))
                                                )
                                        )
                                        .onTapGesture {
                                            viewModel.selectedSegmentIndex = i
                                        }
                                    }
                                }
                                .frame(width: 150, height: 150)
                                .rotationEffect(Angle(degrees: viewModel.rotationDegree))
                                
                                Triangle()
                                    .fill(Color(red: 255/255, green: 215/255, blue: 0/255))
                                    .scaleEffect(y: -1)
                                    .frame(width: 20, height: 20)
                                    .offset(y: -75)
                            }
                            .offset(y: -15)
                            .padding(.top, 20)
                            .alert("Attention", isPresented: $showAlert, actions: {
                                Button("OK", role: .cancel) {}
                            }, message: {
                                Text(viewModel.selectedSegmentIndex == nil ? "Please select a segment before spinning." : "Please set a valid bet amount.")
                            })
                            
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
                                                    
                                                    Text(viewModel.win > 0 ? "\(viewModel.win)" : "0")
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
                                            if viewModel.selectedSegmentIndex == nil {
                                                showAlert = true
                                            } else if viewModel.bet <= 0 {
                                                showAlert = true
                                            } else {
                                                viewModel.spinWheel()
                                            }
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
                                                                .foregroundStyle(.white)
                                                        }
                                                    }
                                            }
                                            .cornerRadius(6)
                                    }

                                    Button(action: {
//                                        viewModel.maxBetAction()
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
    FortuneView()
}


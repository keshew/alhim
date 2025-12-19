import SwiftUI

struct AlhimSettingsView: View {
    @StateObject var alhimSettingsModel =  AlhimSettingsViewModel()
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            
            Rectangle()
                .fill(Color(red: 107/255, green: 21/255, blue: 193/255))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 239/255, green: 57/255, blue: 209/255), lineWidth: 5)
                        .overlay {
                            VStack(spacing: 18) {
                                HStack {
                                    Text("Settings")
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
                                
                                Rectangle()
                                    .fill(Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.1))
                                    .overlay {
                                        HStack {
                                            Image("sound")
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                            
                                            VStack(alignment: .leading) {
                                                Text("Sound Effects")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                                
                                                Text("Enabled")
                                                    .font(.custom("Poppins-Medium", size: 10))
                                                    .foregroundStyle(.white)
                                            }
                                            
                                            Spacer()
                                            
                                            Toggle("", isOn: $alhimSettingsModel.isMusicOn)
                                                .toggleStyle(CustomToggleStyle())
                                                .frame(width: 48)
                                        }
                                        .padding(.horizontal)
                                    }
                                    .frame(height: 50)
                                    .cornerRadius(12)
                                
                                Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.3)
                                    .frame(height: 1)
                                    .padding(.top, 10)
                                
                                VStack {
                                    Rectangle()
                                        .fill(Color(red: 28/255, green: 67/255, blue: 152/255))
                                        .overlay {
                                            HStack {
                                                Image("set1")
                                                    .resizable()
                                                    .frame(width: 16, height: 16)
                                                
                                                Text("About & Help")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                        }
                                        .frame(height: 40)
                                        .cornerRadius(12)
                                    
                                    Rectangle()
                                        .fill(Color(red: 28/255, green: 67/255, blue: 152/255))
                                        .overlay {
                                            HStack {
                                                Image("set2")
                                                    .resizable()
                                                    .frame(width: 16, height: 16)
                                                
                                                Text("Privacy Policy")
                                                    .font(.custom("Poppins-Bold", size: 14))
                                                    .foregroundStyle(.white)
                                                
                                                Spacer()
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
                .frame(width: 300, height: 270)
                .cornerRadius(12)
        }
    }
}

#Preview {
    AlhimSettingsView(show: .constant(true))
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 239/255, green: 57/255, blue: 209/255) : Color(red: 239/255, green: 57/255, blue: 209/255).opacity(0.3))
                .frame(width: 36, height: 20)
                .overlay(
                    Circle()
                        .fill(Color(red: 107/255, green: 21/255, blue: 193/255))
                        .frame(width: 16, height: 16)
                        .offset(x: configuration.isOn ? 7 : -7)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

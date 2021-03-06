import SwiftUI

public struct TitleScreenView: View {
    @EnvironmentObject var playerVariables: PlayerVariables
    @EnvironmentObject var staticGameVariables: StaticGameVariables
    
    @State var enteredUsername: String = ""

    public var body: some View {
        ZStack {
            VStack {
                TitleText(text: "STRATAGEM")
                    .padding(.top, 10)
                
                Spacer()
                
                Button(action: {
                    GameManager(playerVariables: playerVariables, staticGameVariables: staticGameVariables).generateRandomGameCode()
                }) {
                    Text("PLAY")
                }.buttonStyle(BasicButtonStyle())
                .padding(.bottom, 10)
                
                Button(action: {
                    playerVariables.currentView = .JoinGameView
                }) {
                    Text("JOIN")
                }.buttonStyle(BasicButtonStyle())
                .padding(.bottom, 10)
                
                Button(action: {
                }) {
                    Text("LEARN")
                }.buttonStyle(BasicButtonStyle())
                .padding(.bottom, 10)
                
            }.statusBar(hidden: true)
            
            if playerVariables.playerName == "***NIL***" {
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .edgesIgnoringSafeArea(.all)
                
                ZStack {
                    Color.white
                    VStack {
                        Text("SELECT YOUR USERNAME")
                        
                        Spacer()
                        
                        ZStack {
                            TextField("USERNAME", text: $enteredUsername)
                                .onReceive(enteredUsername.publisher.collect()) {
                                    enteredUsername = String($0.prefix(16))
                                }
                                .multilineTextAlignment(.center)
                                .frame(width: 250, height: 40)
                                .font(.custom("Montserrat-Bold", size: 15))
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("ButtonBackground"))
                                .frame(width: 270, height: 40)
                        }
                        
                        if playerVariables.inlineErrorMessage != "" {
                            Text(playerVariables.inlineErrorMessage)
                        }
                        
                        Button(action: {
                            PlayerManager(playerVariables: playerVariables, staticGameVariables: staticGameVariables).assignName(enteredUsername: enteredUsername)
                        }, label: {
                            Text("Confirm")
                        })
                    }.padding()
                }
                .frame(width: 300, height: 200)
                .cornerRadius(20).shadow(radius: 10)
            }
        }
    }
}

struct TitleScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreenView()
            .environmentObject(GameVariables())
            .previewLayout(.fixed(width: 896, height: 414))
    }
}

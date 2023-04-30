import SwiftUI
import Foundation

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var TextFielEmail: String = ""
    @State var SecureFieldPassword: String = ""
    @State var showScreen:Bool = false
    var body: some View {
        NavigationStack{
        VStack {
            Text("Free Place").font(.title).bold().padding().padding(.bottom,30)
            ZStack{
                Color.gray.opacity(0.3).cornerRadius(30)
                VStack{
                    TextField("Email", text:$TextFielEmail)
                    Divider().frame(width: 315, height: 4).overlay(.white).autocorrectionDisabled()
                    SecureField("Contraseña", text:$SecureFieldPassword)
                    Divider().frame(width: 315, height: 4).overlay(.white)
                }.padding()
            }.frame(width: 350, height: 110).padding(.bottom,30)
            
            Button("Entrar"){
                authenticationViewModel.login(email: TextFielEmail, password: SecureFieldPassword)
            }.frame(width: 300, height: 60).background(.black).foregroundColor(.white).cornerRadius(30)
            NavigationLink("¿Olvidaste tu contraseña?", destination: newPassView(), isActive: $showScreen).foregroundColor(.red)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView(authenticationViewModel: AuthenticationViewModel())
    }
}

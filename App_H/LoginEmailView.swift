import SwiftUI

struct LoginEmailView: View {
    
    @State var TextFielEmail: String = ""
    @State var SecureFieldContraseña: String = ""
    
    var body: some View {
        VStack {
            Text("App").font(.title).bold().padding().padding(.bottom,30)
            ZStack{
                Color.gray.opacity(0.3)
                VStack{
                    TextField("Email", text:$TextFielEmail)
                    Divider().frame(width: 315, height: 4).overlay(.white)
                    TextField("Contraseña", text:$SecureFieldContraseña)
                    Divider().frame(width: 315, height: 4).overlay(.white)
                }.padding()
            }.frame(width: 350, height: 110).padding(.bottom,30)
            
            Button("Entrar"){
            }.frame(width: 300, height: 60).background(.black).foregroundColor(.white).cornerRadius(30)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView()
    }
}

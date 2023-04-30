
import SwiftUI

struct PerfilView: View {
    
    @State var TextFielNombre: String = ""
    @State var TextFieldEmail: String = ""
    @State var TextFieldConfirmarContraseña: String = ""
    
    var body: some View {
        ZStack {
            Image("Restablecer").resizable().ignoresSafeArea()
            VStack {
                ZStack{
                    Color.gray.opacity(0.3).cornerRadius(30)
                    VStack{
                        Section("Nombre"){
                            Text("Diego Gael León Martínez")
                            Divider().frame(width: 315, height: 4).overlay(.white)
                        }
                        Section("Email"){
                            Text("0235446@up.edu.mx")
                            Divider().frame(width: 315, height: 4).overlay(.white)
                        }
                    }.padding()
                }.frame(width: 350, height: 140).padding(.bottom,30)
                
            }
        }
    }
    
    struct PerfilView_Previews: PreviewProvider {
        static var previews: some View {
            PerfilView()
        }
    }
}


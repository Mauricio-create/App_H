
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
                            TextField("Aqui debe decir el nombre del usuario", text:$TextFielNombre)
                            Divider().frame(width: 315, height: 4).overlay(.white)
                        }
                        Section("Email"){
                            TextField("Aqui debe decir el email del usuario", text:$TextFieldEmail)
                            Divider().frame(width: 315, height: 4).overlay(.white)
                        }
                        Button("Cerrar"){
                        }.foregroundColor(.red)
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


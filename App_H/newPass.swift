import SwiftUI
import Foundation
import FirebaseAuth

struct newPassView: View {
    
    @State var TextFielEmail: String = ""
    @State var SecureFieldContraseñaNueva: String = ""
    @State var SecureFieldConfirmarContraseña: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Restablecer Contraseña").font(.title).bold().padding().padding(.bottom,30)
                ZStack{
                    Color.gray.opacity(0.3)
                    VStack{
                        TextField("Email", text:$TextFielEmail)
                        Divider().frame(width: 315, height: 4).overlay(.white)
                        TextField("Contraseña Nueva", text:$SecureFieldContraseñaNueva)
                        Divider().frame(width: 315, height: 4).overlay(.white)
                        TextField("Confirmar Contraseña", text:$SecureFieldConfirmarContraseña)
                        Divider().frame(width: 315, height: 4).overlay(.white)
                    }.padding()
                }.frame(width: 350, height: 110).padding(.bottom,30)
                
                Button("Cambiar"){
                    if let user = Auth.auth().currentUser {
                            let newPassword = SecureFieldContraseñaNueva
                            user.updatePassword(to: newPassword) { error in
                                if let error = error {
                                    print("Error al actualizar la contraseña: \(error.localizedDescription)")
                                } else {
                                    print("Contraseña actualizada exitosamente.")
                                }
                            }
                        } else {
                            print("No hay usuario iniciado.")
                        }
                }.frame(width: 300, height: 60).background(.black).foregroundColor(.white).cornerRadius(30)
            }
        }
    }
}





struct newPass_Previews: PreviewProvider {
    static var previews: some View {
        newPassView()
    }
}

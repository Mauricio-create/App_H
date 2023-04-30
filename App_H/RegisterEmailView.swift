//
//  RegisterEmailView.swift
//  App_H
//
//  Created by Adrián Reyes on 29/04/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    @State var textFieldName: String = ""
    @State var textFieldApellido: String = ""
    var body: some View {
        ZStack {
            Image("Registro").resizable().ignoresSafeArea()
            VStack {
                Text("Regístrate").font(.title).bold().padding(.bottom, 30)
                ZStack{
                    Color.gray.opacity(0.3).cornerRadius(30)
                    VStack{
                        TextField("Nombre", text:$textFieldName)
                        Divider().frame(width: 315, height: 4).overlay(.white)
                        TextField("Apellido", text:$textFieldApellido)
                        Divider().frame(width: 315, height: 4).overlay(.white)
                        TextField("Email", text:$textFieldEmail).autocorrectionDisabled()
                        Divider().frame(width: 315, height: 4).overlay(.white)
                        SecureField("Contraseña", text:$textFieldPassword)
                        Divider().frame(width: 315, height: 4).overlay(.white)
                    }.padding()
                }.frame(width: 350, height: 170).padding(.bottom,30)
                Button("Regístrate"){
                    authenticationViewModel.createNewUser(email: textFieldEmail, password: textFieldPassword)
                }.frame(width: 300, height: 60).background(.black).foregroundColor(.white).cornerRadius(30)
                if let messageError = authenticationViewModel.messageError {
                                    Text(messageError)
                                        .bold()
                                        .font(.body)
                                        .foregroundColor(.red)
                                        .padding(.top, 20)
                                }
                
            }
            .padding()
        }
    }
}
struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(authenticationViewModel: AuthenticationViewModel())
    }
}



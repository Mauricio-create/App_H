//
//  RegisterEmailView.swift
//  App_H
//
//  Created by Adrián Reyes on 29/04/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    @State var textFieldName: String = ""
    @State var textFieldApellido: String = ""
    var body: some View {
        VStack {
            Text("Regístrate").font(.title).bold()
            ZStack{
                Color.gray.opacity(0.3)
                VStack{
                    TextField("Nombre", text:$textFieldName)
                    Divider().frame(width: 315, height: 4).overlay(.white)
                    TextField("Apellido", text:$textFieldApellido)
                    Divider().frame(width: 315, height: 4).overlay(.white)
                    TextField("Email", text:$textFieldEmail)
                    Divider().frame(width: 315, height: 4).overlay(.white)
                    TextField("Contraseña", text:$textFieldPassword)
                    Divider().frame(width: 315, height: 4).overlay(.white)
                }.padding()
            }.frame(width: 350, height: 170).padding(.bottom,30)
            Button("Regístrate"){
                
            }.frame(width: 300, height: 60).background(.black).foregroundColor(.white).cornerRadius(30)
            
        }
        .padding()
    }
}
struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView()
    }
}



//
//  ContentView.swift
//  App_H
//
//  Created by Mauricio Castelazo on 29/04/23.
//

import SwiftUI

enum AuthenticationSheetView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationView: View {
    @State private var authenticationSheetView: AuthenticationSheetView?
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        ZStack {
            Image("Inicio").resizable().ignoresSafeArea()
            VStack {
                Image("swiftbeta")
                    .resizable()
                    .frame(width: 200, height: 200)
                VStack {
                    Image("Carro1").resizable().frame(width: 180, height: 150).padding(.bottom, 40)
                    Button(action: {
                        authenticationSheetView = .login
                    }, label: {
                        Text("Iniciar sesión")
                    })
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(30)
                }
                .controlSize(.large)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .padding(.top, 60)
                Spacer()
                HStack {
                    Button {
                        authenticationSheetView = .register
                    } label: {
                        Text("¿No tienes cuenta?")
                        Text("Regístrate")
                            .underline().foregroundColor(.blue)
                    }
                    .tint(.black)
                }
            }
            .sheet(item: $authenticationSheetView) { sheet in
                switch sheet {
                case .register:
                    RegisterEmailView(authenticationViewModel: authenticationViewModel)
                case .login:
                    LoginEmailView(authenticationViewModel: authenticationViewModel)
                }
        }
        }
    }
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authenticationViewModel: AuthenticationViewModel())
    }
}

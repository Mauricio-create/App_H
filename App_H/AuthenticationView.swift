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
    
    var body: some View {
        VStack {
            Image("swiftbeta")
                .resizable()
                .frame(width: 200, height: 200)
            VStack {
                Button(action: {
                    authenticationSheetView = .login
                }, label: {
                    Label("Entra con Email", systemImage: "envelope.fill")
                })
                .tint(.black)
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
                        .underline()
                }
                .tint(.black)
            }
        }
        .sheet(item: $authenticationSheetView) { sheet in
            switch sheet {
            case .register:
                RegisterEmailView()
            case .login:
                LoginEmailView()
            }
        }
    }
}

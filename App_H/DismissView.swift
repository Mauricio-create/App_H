//
//  DismissView.swift
//  App_H
//
//  Created by Adrián Reyes on 29/04/23.
//

import SwiftUI

struct DismissView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button("Cerrar") {
                dismiss()
            }
            .tint(.black)
            .padding(.trailing, 12)
        }
        .textFieldStyle(.roundedBorder)
        .buttonStyle(.bordered)
    }
}

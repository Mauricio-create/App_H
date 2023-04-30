//
//  LocationView.swift
//  App_H
//
//  Created by Mauricio Castelazo on 30/04/23.
//

import SwiftUI
import CoreLocation

struct LocationView: View {
    var lugar:City
    var body: some View {
        ZStack {
            Image("Login").resizable().ignoresSafeArea()
            VStack {
                Text(lugar.name)
                    .font(.title)
                
                Text("Lugares Disponibles: \(lugar.capacity-lugar.spots_taken)")
                Text("Costo por hora: \(lugar.cost.formatted())")
            }
        }
    }
}



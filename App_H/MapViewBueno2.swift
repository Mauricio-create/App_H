//
//  MapViewBueno2.swift
//  App_H
//
//  Created by Adrián Reyes on 23/05/23.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewBueno2: View {
    @StateObject private var apiManager = Lugares_API()
    @State private var annotations: [City] = []
    @State private var showAlert = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.374063076088753, longitude: -99.18268744297909), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02))
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    spot in
                    MapAnnotation(coordinate: spot.coordinate) {
                        NavigationLink {
                            LocationView(lugar: spot)
                        } label: {
                            if (spot.capacity - spot.spots_taken == 0) {
                                Image(systemName: "smiley.fill")
                                    .foregroundColor(.red)
                            } else if (spot.capacity - spot.spots_taken < spot.capacity/4) {
                                Image(systemName: "smiley.fill")
                                    .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "smiley.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                VStack{
                    Spacer()
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: BuscadorView()) {
                            VStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white)
                                Text("Buscador")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        NavigationLink(destination: PerfilView()) {
                            VStack {
                                Image(systemName: "person.circle")
                                    .foregroundColor(.white)
                                Text("Perfil")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            showAlert = true
                        }) {
                            VStack {
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                    .foregroundColor(.white)
                                Text("Logout")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Cerrar sesión"),
                                message: Text("¿Estás seguro?"),
                                primaryButton: .default(Text("Sí")) {
                                    authenticationViewModel.logout()
                                },
                                secondaryButton: .destructive(Text("No")) {
                                    
                                }
                            )
                        }
                        
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.8))
                    .frame(width: 350)
                    .cornerRadius(30)
                }
            }
            .onAppear {
                apiManager.getAllPlaces { places in
                    if let places = places {
                        DispatchQueue.main.async {
                            annotations = places.map { place in
                                City(
                                    name: place.nombre,
                                    coordinate: CLLocationCoordinate2D(
                                        latitude: place.latitud,
                                        longitude: place.longitud
                                    ),
                                    cost: Double(place.costo),
                                    capacity: place.cap_max,
                                    spots_taken: place.disp,
                                    c: Color("blue")
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MapViewBueno2_Previews: PreviewProvider {
    static var previews: some View {
        MapViewBueno2(authenticationViewModel: AuthenticationViewModel())
    }
}

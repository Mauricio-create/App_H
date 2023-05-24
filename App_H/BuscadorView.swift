//
//  BuscadorView.swift
//  App_H
//
//  Created by Adrián Reyes on 23/05/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct BuscadorView:View{
    @StateObject private var apiManager = Lugares_API()
    @State private var annotations:[City]=[]
    @State private var searchText:String=""
    var filteredAnnotations: [City] {
        if searchText.isEmpty {
            return annotations
        } else {
            return annotations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var body: some View{
        NavigationStack{
            List {
                ForEach(filteredAnnotations, id: \.name) { annotation in
                    NavigationLink {
                        LocationView(lugar: annotation)
                    } label: {
                        Text(annotation.name)
                    }
                }
            }
        }.searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: Text("Buscar"))
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

struct BusccadorView_Previews: PreviewProvider {
    static var previews: some View {
        BuscadorView()
    }
}

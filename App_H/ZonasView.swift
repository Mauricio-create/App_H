import SwiftUI
import Foundation

struct ZonasView: View {
    @State private var newPlace = ""
    @State private var places:[ZonasModel] = ZonasModel.Zonas
    private var dataPersistence = DataPersistence()
    @StateObject var posicion=coordenadas()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(places) { place in
                        HStack {
                            Button(action: {
                                posicion.lat=place.latitud
                                posicion.long=place.longitud
                                posicion.ChangeRegion=true
                            }, label: {
                                Text(place.nombre)
                            })
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    places.removeAll(where: { $0 == place })
                                }
                        }.padding()
                    }
                }
                
                TextField("Nuevo lugar", text: $newPlace)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    places.append(ZonasModel(id: newPlace, nombre: newPlace, latitud: 0.0, longitud: 0.0, costo:0.0, cap_max:Int(0.0), disp:Int(0.0)))
                    newPlace = ""
                }, label: {
                    Text("Añadir lugar")
                })
            }
            .navigationTitle("Zona")
        }
        .environmentObject(posicion)
    }
    func addItem(Item: ZonasModel){
        places.append(Item)
    }
}

struct ZonasView_Previews: PreviewProvider {
    static var previews: some View {
        ZonasView()
    }
}


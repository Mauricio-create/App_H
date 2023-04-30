import SwiftUI
import Foundation

struct ZonasView: View {
    @State private var newPlace = ""
    @State private var places=[ZonasModel]()
    private var dataPersistence = DataPersistence()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(places, id: \.self) { place in
                        HStack {
                            Text(place.nombre)
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    places.removeAll(where: { $0 == place })
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Zona")
        }.onAppear{
            do {
                self.places = try dataPersistence.loadItems()
            } catch{
                
            }
        }.onDisappear {
            do {
                try dataPersistence.saveItems(places)
            } catch {
                
            }
        }
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


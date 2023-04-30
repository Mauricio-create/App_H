import SwiftUI
import MapKit

class coordenadas: ObservableObject{
    @Published var lat:Double = 19.374063076088753
    @Published var long:Double = -99.18268744297909
    @Published var ChangeRegion=false
}

struct MapView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @StateObject private var locationManager = LocationManager()
    @State var showAlert: Bool = false
    @State var locations:[ZonasModel] = ZonasModel.Zonas
    @ObservedObject var loc:coordenadas
    var region: Binding<MKCoordinateRegion>? {
        guard let location = locationManager.location else {
            return MKCoordinateRegion.DefaultRegion().getBinding()
        }

        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)

        return region.getBinding()
    }

    var body: some View {
        NavigationView {
            VStack {
                if let region = region {
                    ZStack {
                        Map(coordinateRegion: region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow))
                            .ignoresSafeArea()
                        
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                NavigationLink(destination: ZonasView(), label: {
                                    VStack{
                                        Image(systemName: "signpost.right.and.left").foregroundColor(.white)
                                        Text("Zonas").foregroundColor(.white)
                                    }
                                }).padding()
                                Spacer()
                                NavigationLink(destination: PerfilView(), label: {
                                    VStack{
                                        Image(systemName: "person.circle").foregroundColor(.white)
                                        Text("Perfil").foregroundColor(.white)
                                    }
                                }).padding()
                                Spacer()
                                Button(action:{
                                    showAlert = true
                                }, label:{
                                    VStack{
                                        Image(systemName: "rectangle.portrait.and.arrow.forward").foregroundColor(.white)
                                        Text("Logout").foregroundColor(.white)
                                    }
                                }).padding().alert(isPresented:$showAlert){
                                    Alert(title:Text("Cerrar sesión"), message: Text("¿Estás seguro?"), primaryButton: .default(Text("Sí")){
                                        authenticationViewModel.logout()
                                    }, secondaryButton: .destructive(Text("No")){
                                        
                                    })
                                }
                                Spacer()
                            }.background(.gray.opacity(0.8)).frame(width: 350).cornerRadius(30)
                        }
                        .onReceive(loc.$ChangeRegion) { value in
                            if value {
                                let newRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: loc.lat, longitude: loc.long), latitudinalMeters: 500, longitudinalMeters: 500)
                                region.wrappedValue = newRegion
                                loc.ChangeRegion = false
                            }
                        }

                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.black)
        

    }
}

extension MKCoordinateRegion {

    static func DefaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.374063076088753, longitude: -99.18268744297909), latitudinalMeters: 500, longitudinalMeters: 500)
    }
    func getBinding() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(authenticationViewModel: AuthenticationViewModel(), loc:coordenadas())
    }
}

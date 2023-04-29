import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @StateObject private var locationManager = LocationManager()
    @State var showAlert:Bool = false
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
                Text("Bienvenido \(authenticationViewModel.user?.email ?? "No user")")
                    .padding(.top, 32)
                Spacer()
                if let region = region {
                    ZStack{
                        Map(coordinateRegion: region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow))
                            .ignoresSafeArea()
                        VStack{
                            HStack{
                                
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    showAlert = true
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Cerrar sesión"), message: Text("¿Estas seguro?"), primaryButton: .default(Text("Yes")){
                        authenticationViewModel.logout()
                    }, secondaryButton: .default(Text("No")){
                    })
                    
                }
            }
        }
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
        MapView(authenticationViewModel: AuthenticationViewModel())
    }
}




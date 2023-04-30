import MapKit
import SwiftUI

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let cost: Double
    let capacity: Int
    let spots_taken:Int
    var c:Color
    mutating func ChangeColor(spots:Int,taken:Int){
        if spots-taken==0{
            c=Color.red
        }
        else{
            c=Color.green
        }
    }
}

struct MapViewBueno: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.374063076088753, longitude: -99.18268744297909), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02))
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var showAlert: Bool = false
    @State var color:Color = .blue

    let annotations = [
        City(name: "Plaza Universidad", coordinate: CLLocationCoordinate2D(latitude: 19.367404116160845, longitude: -99.16685200327753),cost:50,capacity:100,spots_taken:0, c:Color("blue")),
        City(name: "Patio Universidad", coordinate: CLLocationCoordinate2D(latitude: 19.36628152047223, longitude: -99.16724146137531),cost:50,capacity:300,spots_taken:90, c:Color("blue")),
        City(name: "Galerías Insurgentes", coordinate: CLLocationCoordinate2D(latitude: 19.37106103969733, longitude: -99.17870024860294),cost:50,capacity:150,spots_taken:80, c:Color("blue")),
        City(name: "Manacar", coordinate: CLLocationCoordinate2D(latitude: 19.36900122769999, longitude: -99.18120930442325),cost:50,capacity:120,spots_taken:50, c:Color("blue")),
        City(name: "Pabellón del Valle", coordinate: CLLocationCoordinate2D(latitude:19.372975288609943, longitude: -99.1630787703757),cost:50,capacity:200,spots_taken:20, c:Color("blue"))
    ]

    var body: some View {
        NavigationView{
            ZStack{
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    //                    MapPin(coordinate: $0.coordinate)
                    MapMarker(coordinate: $0.coordinate, tint: Color.red)
                    
                }
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
            }
        }
    }
}

struct MapViewBueno_Previews: PreviewProvider {
    static var previews: some View {
        MapViewBueno(authenticationViewModel: AuthenticationViewModel())
    }
}

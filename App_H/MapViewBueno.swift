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
        City(name: "Plaza Universidad", coordinate: CLLocationCoordinate2D(latitude: 19.367404116160845, longitude: -99.16685200327753),cost:50,capacity:113,spots_taken:107, c:Color("blue")),
        City(name: "Patio Universidad", coordinate: CLLocationCoordinate2D(latitude: 19.36628152047223, longitude: -99.16724146137531),cost:50,capacity:74,spots_taken:68, c:Color("blue")),
        City(name: "Galerías Insurgentes", coordinate: CLLocationCoordinate2D(latitude: 19.37106103969733, longitude: -99.17870024860294),cost:50,capacity:213,spots_taken:175, c:Color("blue")),
        City(name: "Manacar", coordinate: CLLocationCoordinate2D(latitude: 19.36900122769999, longitude: -99.18120930442325),cost:50,capacity:312,spots_taken:254, c:Color("blue")),
        City(name: "Pabellón del Valle", coordinate: CLLocationCoordinate2D(latitude:19.372975288609943, longitude: -99.1630787703757),cost:50,capacity:100,spots_taken:46, c:Color("blue")),
        City(name: "Taqueria hermanos luna", coordinate: CLLocationCoordinate2D(latitude:19.37490, longitude: -99.18805),cost:50,capacity:29,spots_taken:27, c:Color("blue")),
        City(name: "Casino Life", coordinate: CLLocationCoordinate2D(latitude:19.374338, longitude: -99.17849),cost:50,capacity:200,spots_taken:20, c:Color("blue")),
        City(name: "Universidad Simon Bolivar", coordinate: CLLocationCoordinate2D(latitude:19.37191, longitude: -99.18528),cost:50,capacity:56,spots_taken:56, c:Color("blue")),
        City(name: "Afore Mixcoac", coordinate: CLLocationCoordinate2D(latitude:19.37477, longitude: -99.18451),cost:50,capacity:200,spots_taken:20, c:Color("blue")),
        City(name: "Go Karts", coordinate: CLLocationCoordinate2D(latitude:19.36874, longitude: -99.18046),cost:50,capacity:200,spots_taken:20, c:Color("blue")),
        City(name: "Banco City Banamex", coordinate: CLLocationCoordinate2D(latitude:19.37398, longitude: -99.17849),cost:50,capacity:23,spots_taken:20, c:Color("blue")),
        City(name: "Ofice Depot", coordinate: CLLocationCoordinate2D(latitude:19.37541, longitude: -99.18710),cost:50,capacity:29,spots_taken:29, c:Color("blue")),
        City(name: "Stand-Up Bar", coordinate: CLLocationCoordinate2D(latitude:19.37536, longitude: -99.17814),cost:50,capacity:10,spots_taken:6, c:Color("blue")),
        City(name: "Walmart", coordinate: CLLocationCoordinate2D(latitude:19.37214, longitude: -99.17529),cost:50,capacity:280,spots_taken:174, c:Color("blue")),
        City(name: "Hiper Lumen", coordinate: CLLocationCoordinate2D(latitude:19.37406, longitude: -99.17292),cost:50,capacity:26,spots_taken:25, c:Color("blue"))
    ]

    var body: some View {
        NavigationView{
            ZStack{
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    spot in
                    //                    MapPin(coordinate: $0.coordinate)
                    MapAnnotation(coordinate: spot.coordinate){
                        NavigationLink {
                            LocationView(lugar: spot)
                        }label:{
                            if(spot.capacity-spot.spots_taken==0){
                                Image(systemName:"smiley.fill")
                                    .foregroundColor(.red)
                            }
                            else if((spot.capacity-spot.spots_taken) < (spot.capacity/4)){
                                Image(systemName:"smiley.fill")
                                    .foregroundColor(.yellow)
                            }
                            else{
                                Image(systemName: "smiley.fill")
                                    .foregroundColor(.green)
                            }
                            
                        }
                    }
                    
                    
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

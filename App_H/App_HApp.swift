//
//  App_HApp.swift
//  App_H
//
//  Created by Mauricio Castelazo on 29/04/23.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


struct ParkingSpot: Identifiable {
    let id: String
    let name: String
    let availableSpots: Int
}

class ParkingSpotViewModel: ObservableObject {
    @Published var parkingSpots = [ParkingSpot]()
    let ref = Database.database(url: "https://estacionamiento-1f782-default-rtdb.firebaseio.com/").reference()
    let parkingSpotsRef: DatabaseReference
    
    init() {
        parkingSpotsRef = ref.child("parkingSpots")
        
        // Observar cambios en los datos de la referencia de Firebase
        parkingSpotsRef.observe(.value) { snapshot in
            var newParkingSpots = [ParkingSpot]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let name = value["name"] as? String,
                   let availableSpots = value["availableSpots"] as? Int {
                    let parkingSpot = ParkingSpot(id: snapshot.key, name: name, availableSpots: availableSpots)
                    newParkingSpots.append(parkingSpot)
                }
            }
            self.parkingSpots = newParkingSpots
        }
    }
}

struct ParkingSpotListView: View {
    @ObservedObject var parkingSpotViewModel = ParkingSpotViewModel()
    
    var body: some View {
        NavigationView {
            List(parkingSpotViewModel.parkingSpots) { parkingSpot in
                VStack(alignment: .leading) {
                    Text(parkingSpot.name)
                    Text("\(parkingSpot.availableSpots) spots available")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Parking Spots")
        }
    }
}

// ...




@main
struct App_HApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            if let _ = authenticationViewModel.user {
                            //Text("User logged! \(user.email)")
                            MapView(authenticationViewModel: authenticationViewModel)
                        } else {
                            AuthenticationView(authenticationViewModel: authenticationViewModel)
                        }
        }
    }
}

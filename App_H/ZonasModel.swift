//
//  ZonasModel.swift
//  App_H
//
//  Created by Mauricio Castelazo on 29/04/23.
//

import Foundation
import SwiftUI
import Firebase




struct ZonasModel: Identifiable,Codable, Hashable{

    var id:String
    var nombre:String
    var latitud:Double
    var longitud:Double
    var costo:Float
    var cap_max:Int
    var disp:Int
}


extension ZonasModel{
    static let Zonas=[
        ZonasModel(id:UUID().uuidString,nombre:"Plaza Universidad",latitud:19.367404116160845, longitud: -99.16685200327753, costo: 50, cap_max:100, disp:100),
        ZonasModel(id:UUID().uuidString,nombre:"Lugar B",latitud:19.367404116160845, longitud: -90.16685200327753, costo:0, cap_max:200, disp:200),
        ZonasModel(id:UUID().uuidString,nombre:"Lugar C",latitud:19.367404116160845, longitud: -93.16685200327753, costo:0, cap_max:300, disp:300)
    ]
}

func obtenerZonasDeFirestore() {
    let db = Firestore.firestore()

    db.collection("Estacionamiento").getDocuments { (snapshot, error) in
        if let error = error {
            print("Error al obtener datos de Firestore: \(error.localizedDescription)")
            return
        }

        guard let snapshot = snapshot else {
            print("No se encontraron documentos")
            return
        }

        let zonas = snapshot.documents.map { (document) -> ZonasModel in
            let data = document.data()
            let id = document.documentID
            let nombre = data["nombre"] as? String ?? ""
            let latitud = data["latitud"] as? Double ?? 0
            let longitud = data["longitud"] as? Double ?? 0
            let costo = data["costo"] as? Float ?? 0
            let cap_max = data["cap_max"] as? Int ?? 0
            let disp = data["disp"] as? Int ?? 0

            return ZonasModel(id: id, nombre: nombre, latitud: latitud, longitud: longitud, costo: costo, cap_max: cap_max, disp: disp)
        }

        // Haz lo que quieras con la variable "zonas", que contiene las instancias de ZonasModel
    }
}


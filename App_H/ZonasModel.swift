//
//  ZonasModel.swift
//  App_H
//
//  Created by Mauricio Castelazo on 29/04/23.
//

import Foundation
import SwiftUI

struct ZonasModel: Identifiable,Codable, Hashable{

    var id:UUID
    var nombre:String
    var latitud:Double
    var longitud:Double
    var costo:Double
    
}
extension ZonasModel{
    static let Zonas=[
        ZonasModel(id:UUID(),nombre:"Plaza Universidad",latitud:19.367404116160845, longitud: -99.16685200327753, costo: 50),
        ZonasModel(id:UUID(),nombre:"Lugar B",latitud:19.367404116160845, longitud: -90.16685200327753, costo:0),
        ZonasModel(id:UUID(),nombre:"Lugar C",latitud:19.367404116160845, longitud: -93.16685200327753,, costo:0),
    ]
}

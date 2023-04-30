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
        ZonasModel(id:UUID().uuidString,nombre:"Patio Universidad",latitud:19.36628152047223, longitud:  -99.16724146137531, costo:0, cap_max:200, disp:200),
        ZonasModel(id:UUID().uuidString,nombre:"Universidad Panamericana",latitud:19.37300328192388, longitud: -99.18393299133301, costo:0, cap_max:300, disp:300),
        ZonasModel(id:UUID().uuidString,nombre:"Galerías Insurgentes",latitud:19.37106103969733, longitud: -99.17870024860294, costo: 50, cap_max:100, disp:100),
        ZonasModel(id:UUID().uuidString,nombre:"Manacar",latitud:19.36900122769999, longitud: -99.18120930442325, costo:0, cap_max:200, disp:200),
        ZonasModel(id:UUID().uuidString,nombre:"Pabellón del Valle",latitud:19.372975288609943, longitud: -99.1630787703757, costo:0, cap_max:300, disp:300)
    ]
}




//
//  API.swift
//  App_H
//
//  Created by Adrián Reyes on 23/05/23.
//
import Foundation


final class Lugares_API: ObservableObject{
    
    struct Place: Codable {
        let id: Int
        let nombre: String
        let latitud: Double
        let longitud: Double
        let costo: Int
        let cap_max: Int
        let disp: Int
    }
    
    func getAllPlaces(completion: @escaping ([Place]?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/") else {
            print("URL inválida")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Respuesta inválida del servidor")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let places = try JSONDecoder().decode([Place].self, from: data)
                    completion(places)
                } catch {
                    print("Error al decodificar los datos JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    func getPlaceByID(id: Int, completion: @escaping (Place?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/place/\(id)") else {
            print("URL inválida")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Respuesta inválida del servidor")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let place = try JSONDecoder().decode(Place.self, from: data)
                    completion(place)
                } catch {
                    print("Error al decodificar los datos JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}



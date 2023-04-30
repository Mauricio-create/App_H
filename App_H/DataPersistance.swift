//
//  DataPersistance.swift
//  App_H
//
//  Created by Mauricio Castelazo on 29/04/23.
//

import Foundation

class DataPersistence: ObservableObject {
    
    private let fileManager = FileManager.default
    private let documentsDirectory: URL
    private let itemsURL: URL
    
    init() {
        //         Creating an instance of the FileManager class, which provides access to the file system. Using the instance's urls(for:in:) method to get the URL for the app's document directory. Document Directory is what is persisted to ICloud
        
        self.documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.itemsURL = documentsDirectory.appendingPathComponent("items").appendingPathExtension("json")
    }
    
    
    func saveItems(_ items: [ZonasModel]) throws {
        let encoder = JSONEncoder()
        let encodedItems = try encoder.encode(items)
        try encodedItems.write(to: itemsURL)
    }
    
    func loadItems() throws -> [ZonasModel] {
        guard fileManager.fileExists(atPath: itemsURL.path) else {
            return []
        }
        
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: itemsURL)
        let decodedItems = try decoder.decode([ZonasModel].self, from: data)
        return decodedItems
    }
}

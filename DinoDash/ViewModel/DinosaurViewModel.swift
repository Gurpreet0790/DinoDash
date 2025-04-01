//
//  DinoDetails.swift
//  DinoDash
//
//  Created by ReetDhillon on 2025-03-10.
//

import Foundation

class DinosaurViewModel {
    var allDinosData: [DinoDataModel] = []
    var dinoData: [DinoDataModel] = []
    
    init() {
        decodeDinoData()
    }
    
    //Decode DinosJson Data to Dino Model
    func decodeDinoData(){
        
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: ".json") {
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allDinosData = try decoder.decode([DinoDataModel].self, from: data)
                dinoData = allDinosData
            } catch{
                print("Error decoding JSON data: \(error)")
            }
        }
            
    }
    
    func search(for searchItem: String) -> [DinoDataModel]{
        if searchItem.isEmpty{
            return dinoData
        } else {
            return dinoData.filter{ dino in
                dino.name.localizedCaseInsensitiveContains(searchItem)
            }
        }
    }
    
    func sort(by alaphbetical: Bool)
    {
        dinoData.sort { dino1, dino2 in
            if alaphbetical {
                dino1.name < dino2.name
            }
            else {
                dino1.id < dino2.id
            }
        }
    }
    
    func filter(by type: dinoType) {
        if type == .all {
            dinoData = allDinosData
        } else {
            dinoData = allDinosData.filter { dino in
                dino.type == type
            }
        }
    }
    
    func removeDino(at offsets: IndexSet) {
        allDinosData.remove(atOffsets: offsets)
    }
}

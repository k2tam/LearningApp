//
//  ContentModel.swift
//  LearningApp
//
//  Created by k2 tam on 12/07/2022.
//

import Foundation

class ContentModel : ObservableObject {
    @Published var modules = [Module]()
    
    init(){
        getLocalData()
    }
    
    func getLocalData() -> [Module]{
        //MARK: Get local json data
        
        //get url to the json file
        let url = Bundle.main.url(forResource: "data", withExtension: "json")
        
        
        //Return empty module array if url is nil
        guard url != nil else{
            return [Module]()
        }
        
        
        do{
            //Get data object from the contents of url
            let data = try Data(contentsOf: url!)
            
            //Try to decode data object to [Module]
            let decoder = JSONDecoder()
            
            
            do{
                let modules = try decoder.decode([Module].self, from: data)
                self.modules = modules

            }catch{
                print("decode data error")
            }
            
        }catch{
            print("data object error")
        }
        
        return [Module]()
    }
}

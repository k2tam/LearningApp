//
//  ContentModel.swift
//  LearningApp
//
//  Created by k2 tam on 12/07/2022.
//

import Foundation

class ContentModel : ObservableObject {
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule: Module?
    var currentIndexModule = 0
    
    //Current lesson
    @Published var currentLesson: Lesson?
    var currentIndexLesson = 0
    
    
    init(){
        getLocalData()
    }
    
    //MARK: Data methods

    func getLocalData() -> [Module]{
        
        
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
    
    //MARK: Modudle navigation methods
    
    func beginModule(_ moduleId: Int){
        
        //Find index for module id
        for index in 0..<modules.count{
            if modules[index].id == moduleId{
                //Found matching module
                currentIndexModule = index
                break
            }
        }
        //Set current module
        
        currentModule = modules[currentIndexModule]
    }
    
    func beginLesson(_ lessonIndex: Int){
        if lessonIndex < currentModule!.content.lessons.count{
            currentIndexLesson = lessonIndex
        }else{
            currentIndexLesson = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentIndexLesson]
    }
    
    func nextLesson(){
        currentIndexLesson += 1
        
        //Check next current lesson within in range
        if(currentIndexLesson < currentModule!.content.lessons.count){
            //Set current lesson property
            currentLesson = currentModule!.content.lessons[currentIndexLesson]
        }else{
            currentIndexLesson = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool{
        return (currentIndexLesson+1 < currentModule!.content.lessons.count)
    }
}

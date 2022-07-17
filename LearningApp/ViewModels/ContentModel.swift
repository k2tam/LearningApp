//
//  ContentModel.swift
//  LearningApp
//
//  Created by k2 tam on 12/07/2022.
//

import Foundation
import SwiftUI

class ContentModel : ObservableObject {
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule: Module?
    var currentIndexModule = 0
    
    //Current lesson
    @Published var currentLesson: Lesson?
    var currentIndexLesson = 0
    
    //Current question
    @Published var currentQuestion: Question?
    var currentIndexQuestion = 0
    
    //Current lesson explaination
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    //Current content and test selected
    @Published var currentContentSelected :Int?
    @Published var currentTestSelected :Int?
    
    init(){
        //Parse local included json data
        getLocalData()
        
        
        //Download remote json file and parse data
        getRemoteData()
    }
    
    //MARK: Data methods
    
    func getRemoteData(){
        //String path
        let urlString = "https://k2tam.github.io/learningapp-data/data2.json"
        
        //Create url object
        let url = URL(string: urlString)
        
        guard url != nil else{
            //Couldn't create url
            return
        }
        
        //Create a url request object
        let request = URLRequest(url: url!)
        
        //Get the session and kick off the task
        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            //Check if there is an error
            guard error == nil else {
                //There was an error
                return
            }
                        
            //Create json decoder
            let decoder = JSONDecoder()
            
            do{
                //Decode
                let modules = try decoder.decode([Module].self, from: data!)
                
                //Append parsed modules into modules property
                self.modules += modules

            }catch{
                
            }
            
        }
        
        //Kick off data task
        dataTask.resume()
        
    }

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
            
            //Parse data style
            let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
            
            
            do{
                //Read data url to data object
                let styleData = try Data(contentsOf: styleUrl!)
                self.styleData = styleData
                
            }catch{
                print("Cannot parse style data")
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
        
        
        //Set current lesson
        currentLesson = currentModule!.content.lessons[currentIndexLesson]
        codeText = addStyling(currentLesson!.explanation) 
    }
    
    func nextLesson(){
        currentIndexLesson += 1
        
        //Check next current lesson within in range
        if(currentIndexLesson < currentModule!.content.lessons.count){
            //Set current lesson property
            currentLesson = currentModule!.content.lessons[currentIndexLesson]
            codeText = addStyling(currentLesson!.explanation)

        }else{
            currentIndexLesson = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool{
        return (currentIndexLesson+1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleId:Int){
        
        //Set current module
        beginModule(moduleId)
        
        
        //Set current question index
        currentIndexQuestion = 0
        
        //if there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0{
            currentQuestion = currentModule!.test.questions[currentIndexQuestion]
            
            //Set the question content
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion(){
        //Advance the question index
        currentIndexQuestion += 1
        
        //Check that it's within the range of questions
        if currentIndexQuestion < currentModule!.test.questions.count{
            //Set the current quesion
            currentQuestion = currentModule!.test.questions[currentIndexQuestion]
            codeText = addStyling(currentQuestion!.content)
        }else{
            //If not, then reset the properties
            currentIndexQuestion = 0
            currentQuestion = nil
        }
        
        
    }
    
    //MARK: CODE STYLING
    private func addStyling(_ htmlString: String) -> NSAttributedString{
        var resultString = NSAttributedString()
        var data = Data()
        
        //Add styling data
        if(styleData != nil){
            data.append(self.styleData!)

        }
        
        //Add the html data
        data.append(Data(htmlString.utf8))
        
        //Convert to attributed string
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        
            
       
        
        return resultString
        
    }
    
}

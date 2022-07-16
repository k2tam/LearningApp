//
//  ContentViewDetail.swift
//  LearningApp
//
//  Created by k2 tam on 14/07/2022.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl+(lesson?.video ?? ""))
        
        VStack{
            if(url != nil){
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
                
            }
            
            //Description
            CodeTextView()
            
            //Next lesson button
            //Only show next lesson button, only if there is a next lesson
            if model.hasNextLesson() {
                
                Button {
                    model.nextLesson()
                } label: {
                    
                    ZStack{
                        RectangleView(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Next lesson \(model.currentModule!.content.lessons[model.currentIndexLesson+1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                    
                }
            }
            else{
                //Show complete lessons instead
                Button {
                    //Take user back to HomeView
                    model.currentContentSelected = nil
                } label: {
                    
                    ZStack{
                        RectangleView(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                    
                }
            }
            
        }
            .padding()
            .navigationTitle(lesson?.title ?? "")
        
    }
    
    
}




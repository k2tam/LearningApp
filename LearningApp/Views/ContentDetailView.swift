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
            
            //Next lesson button
            //Only show next lesson button, only if there is a next lesson
            if model.hasNextLesson() {
                
                Button {
                    model.nextLesson()
                } label: {
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height: 48)
                        
                        Text("Next lesson \(model.currentModule!.content.lessons[model.currentIndexLesson+1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                    
                }
            }
            
        }
            .padding()
        
        
    }
    
    
}




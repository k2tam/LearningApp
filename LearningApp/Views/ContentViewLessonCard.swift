//
//  ContentViewLessonCard.swift
//  LearningApp
//
//  Created by k2 tam on 13/07/2022.
//

import SwiftUI

struct ContentViewLessonCard: View {
    @EnvironmentObject var model:ContentModel
    var index:Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        
        //Lesson card
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack(spacing: 30){
                Text(String(index+1))
                    .bold()
                
                VStack(alignment: .leading){
                    Text(lesson.title)
                        .bold()
                    
                    Text(lesson.duration)
                }
            }
            .padding()
            
        }
    }
}


struct Previews_ContentViewLessonCard_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

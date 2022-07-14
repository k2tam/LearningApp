//
//  ContentView.swift
//  LearningApp
//
//  Created by k2 tam on 13/07/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model:ContentModel
    
    
    var body: some View{
        ScrollView{
            LazyVStack{
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count){index in
                        
                        NavigationLink {
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(index)
                                }
                        } label: {
                            ContentViewLessonCard(index: index)
                                .accentColor(.black)
                        }

                        
                    }
                }
            }
            
        }
        .padding()
        .navigationTitle("Learn \(model.currentModule?.category ?? "")")
    }
}




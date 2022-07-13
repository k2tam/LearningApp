//
//  ContentView.swift
//  LearningApp
//
//  Created by k2 tam on 12/07/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("What do you want to learn ?")
                    .padding(.leading, 16)
                
                ScrollView{
                    LazyVStack(){
                        ForEach(model.modules){module in
                            
                            //Learning card
                            HomeViewLearingCard(image: module.content.image, title: module.category, description: module.content.description, volume: "\(module.content.lessons.count) Lessons", time: module.content.time)
                            
                            //Test card
                            HomeViewLearingCard(image: module.test.image, title: "\(module.category) Test", description: module.test.description, volume: "\(module.test.questions.count) Questions", time: module.test.time)
                            
                        }
                       
                        
                       
                    }.padding()
                }
            }.navigationTitle("Get Started")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}

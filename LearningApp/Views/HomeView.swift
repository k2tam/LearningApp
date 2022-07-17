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
                            
                            NavigationLink(
                                destination:
                                    ContentView()
                                        .onAppear {
                                            model.beginModule(module.id)
                                        },
                                tag:module.id,
                                selection:$model.currentContentSelected,
                            
                                label: {
                                    //Learning card
                                    HomeViewLearingCard(image: module.content.image, title: module.category, description: module.content.description, volume: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                })
                            
                            
                            NavigationLink(
                                destination:
                                    TestView()
                                        .onAppear(perform: {
                                            model.beginTest(module.id)
                                        }),
                                tag: module.id,
                                selection: $model.currentTestSelected,
                                label: {
                                    //Test card
                                    HomeViewLearingCard(image: module.test.image, title: "\(module.category) Test", description: module.test.description, volume: "\(module.test.questions.count) Questions", time: module.test.time)
                                })
                        }
                       
                        
                       
                    }
                    .padding()
                    .accentColor(.black)
                }
            }.navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}

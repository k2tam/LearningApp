//
//  TestView.swift
//  LearningApp
//
//  Created by k2 tam on 16/07/2022.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    
    @State var submited = false
    @State var selectedAnswerIndex:Int?
    
    @State var numCorrect = 0
    
    var body: some View {
        NavigationView{
            if model.currentQuestion != nil{
                VStack(alignment: .leading){
                    //Question number
                    Text("Question \(model.currentIndexQuestion+1) of \((model.currentModule?.test.questions.count ?? 0))")
                        .padding(.leading ,20)
                    
                    //Question
                    CodeTextView()
                        .padding(.horizontal, 20)
                    //Answers
                    
                    ScrollView {
                        VStack {
                            ForEach(0..<model.currentQuestion!.answers.count, id: \.self){ index in
                                
                                Button {
                                    //Track the seleted index
                                    selectedAnswerIndex = index
                                    
                                } label: {
                                    ZStack{
                                        if submited == false{
                                            RectangleView(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48)
                                        }else{
                                            if selectedAnswerIndex == index && selectedAnswerIndex == model.currentQuestion?.correctIndex {
                                                //Show green button
                                                RectangleView(color: Color.green)
                                                    .frame(height: 48)
                                            }
                                            else if selectedAnswerIndex == index && selectedAnswerIndex != model.currentQuestion?.correctIndex{
                                                RectangleView(color: Color.red)
                                                    .frame(height: 48)
                                            }
                                            else if index == model.currentQuestion?.correctIndex{
                                                RectangleView(color: Color.green)
                                                    .frame(height: 48)
                                            }
                                            else{
                                                RectangleView(color: Color.white)
                                                    .frame(height: 48)
                                            }
                                            
                                                
                                                
                                        }
                                       
                                        Text(model.currentQuestion!.answers[index])

                                    }

                                }
                                .disabled(submited)

                            }
                        }
                        .padding()
                        .foregroundColor(Color.black)
                    }
                    
                    //Button
                    Button {
                        submited = true
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                            numCorrect += 1
                        }
                    } label: {
                        ZStack{
                            RectangleView(color: Color.green)
                                .frame(height: 48)
                            
                            Text("Submit")
                                .bold()
                                .foregroundColor(Color.white)
                                
                        }
                        .padding()
                    }
                    .disabled(selectedAnswerIndex == nil)

                }
                .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            }
            
        }
       
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(ContentModel())
    }
}

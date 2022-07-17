//
//  TestResultView.swift
//  LearningApp
//
//  Created by k2 tam on 17/07/2022.
//

import SwiftUI

struct TestResultView: View {
    @EnvironmentObject var model:ContentModel
    
    var numCorrect:Int
    var resultHeading:String{
        guard model.currentModule != nil else{
            return ""
        }
        
        let percent = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if(percent > 0.5){
            return "Awesome !"
        }
        else if(percent > 0.2){
            return "Doing great !"
        }
        else{
            return "Keep learning !"
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            Text(resultHeading)
                .font(.title)
            Spacer()
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            Spacer()
            Button {
                //Send the user back to the Home View
                model.currentTestSelected = nil
            } label: {
                ZStack{
                    RectangleView(color: Color.green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            Spacer()

            
        }
    }
}


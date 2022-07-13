//
//  HomeViewLearingCard.swift
//  LearningApp
//
//  Created by k2 tam on 13/07/2022.
//

import SwiftUI

struct HomeViewLearingCard: View {
    
    var image: String
    var title: String
    var description: String
    var volume: String
    var time: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack{
                //Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                //Text
                VStack(alignment: .leading, spacing: 10){
                    //Heading
                    Text("Learning \(title)")
                    
                    
                    //Description
                    Text(description)
                        .font(.caption)
                        .padding(.bottom, 30)
                    
                    HStack{
                        //Number of lessons / tests
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text(volume)
                            .font(.caption)
                            .font(Font.system(size: 12))
                        
                        
                        //Time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text(time)
                            .font(.caption)
                            .font(Font.system(size: 12))

                    }
                }
                
            }
            .padding([.leading, .trailing], 20)
            
            
            
            
        }
    }
}

struct HomeViewLearingCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewLearingCard(image: "swift", title: "Swift", description: "This is title", volume: "20 lessons", time: "3 hours")
    }
}

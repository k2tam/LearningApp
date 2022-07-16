//
//  RectangleView.swift
//  LearningApp
//
//  Created by k2 tam on 16/07/2022.
//

import SwiftUI

struct RectangleView: View {
    var color = Color.white
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}

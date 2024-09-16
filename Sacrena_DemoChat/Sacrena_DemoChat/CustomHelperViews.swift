//
//  CustomHelperViews.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 15/09/24.
//

import Foundation
import SwiftUI

struct CustomListRowSeparator: View {
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color.gray.opacity(0.2))
            .frame(height: 1)
            .blendMode(.screen)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }
}


struct CustomOnlineIndicatorView: View {
    let isOnline: Bool
    
    var body: some View {
        Circle()
            .fill(isOnline ? Color.green : Color.gray)
            .frame(width: 12, height: 12)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

struct SimpleCircleView: View {
    var body: some View {
        Circle()
            .fill(Color.black)  // Fill the circle with white color
            .frame(width: 6, height: 6)  // Set the size of the circle
            .shadow(radius: 5)  // Optional: Add a shadow for a better look
    }
}

//
//  CustomMessageComposerModifier.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 15/09/24.
//

import Foundation
import SwiftUI


struct BackgroundViewModifier: ViewModifier {

    public func body(content: Content) -> some View {
        content
            .background(Color(hex: "#272727"))
    }
}

struct CustomSendMessageButton: View {
    let enabled: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap, label: {
            Image(systemName: "arrow.up")
                .foregroundColor(enabled ? .white : .gray)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(enabled ? Color.blue : Color.gray.opacity(0.3))
                .clipShape(Circle())
        })
        .disabled(!enabled)
    }
}

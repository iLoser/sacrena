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

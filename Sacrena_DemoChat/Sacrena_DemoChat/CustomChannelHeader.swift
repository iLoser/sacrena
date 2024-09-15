//
//  CustomChannelHeader.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 15/09/24.
//

import Foundation
import SwiftUI
import StreamChat
import StreamChatSwiftUI



struct CustomChannelHeader: ToolbarContent {

    @Injected(\.fonts) var fonts
    @Injected(\.images) var images

    public var title: String

    public var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.white)
        }
    }
}

struct CustomChannelModifier: ChannelListHeaderViewModifier {

    var title: String

    func body(content: Content) -> some View {
        content.toolbar {
            CustomChannelHeader(title: title)
        }.background(Color(hex: "#272727"))
        
    }

}


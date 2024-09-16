//
//  CustomChatChannelHeadModifier.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 15/09/24.
//

import Foundation
import SwiftUI
import StreamChat
import StreamChatSwiftUI


struct CustomChatChannelHeaderModifier: ChatChannelHeaderViewModifier {
    let channel: ChatChannel
    @ObservedObject private var channelHeaderLoader = InjectedValues[\.utils].channelHeaderLoader
    @State private var isActive: Bool = false
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CustomChatChannelHeader(channel: channel, avatar: channelHeaderLoader.image(for: channel))
                }
            }
            .navigationBarBackButtonHidden(true)
    }
    
}

struct CustomChatChannelHeader: View {

    @Injected(\.fonts) var fonts
    @Injected(\.images) var images
    @Injected(\.utils) private var utils
    @Injected(\.chatClient) private var chatClient
    @Environment(\.presentationMode) var presentationMode

    public var channel: ChatChannel
    let avatar: UIImage

    private var onlineIndicatorShown: Bool {
        !channel.lastActiveMembers.filter { member in
            member.id != chatClient.currentUserId && member.isOnline
        }
        .isEmpty
    }

    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                        Image(uiImage: avatar)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(
                                onlineIndicatorShown ? Circle().fill(Color.green)
                                    .frame(width: 10, height: 10)
                                    .offset(x: -16, y: 12) : nil
                            )
                        Text(utils.channelNamer(channel, chatClient.currentUserId) ?? "User Name")
                            .font(fonts.bodyBold)
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal, 10)
                    }
                }
                Spacer() // Ensures content pushes left
                HStack(spacing: 4) {
                    SimpleCircleView()
                    SimpleCircleView()
                    SimpleCircleView()
                }
            }
        }
        
    }
}


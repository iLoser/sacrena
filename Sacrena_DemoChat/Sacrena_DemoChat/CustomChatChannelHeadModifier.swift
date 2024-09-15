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
        content.toolbar {
            CustomChatChannelHeader(channel: channel, avatar: channelHeaderLoader.image(for: channel))
            
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
        .background(Color(hex: "#272727"))
    }
    
}

struct CustomChatChannelHeader: ToolbarContent {
    
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
    
     var body: some ToolbarContent {
        // Back button and avatar on the left
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                        Image(uiImage: avatar)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.vertical, 10)
                            .overlay(
                                onlineIndicatorShown ? Circle().fill(Color.green).frame(width: 10, height: 10).offset(x: -16, y: 12) : nil
                            )
                    }
                    .background(Color(hex: "#272727"))
                }
            }
            
            // Channel name in the center
            ToolbarItem(placement: .principal) {
                Text(utils.channelNamer(channel, chatClient.currentUserId) ?? "User Name")
                    .font(fonts.bodyBold)
                    .accessibilityIdentifier("chatName")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: "#272727"))
            }
            
            // Three circles on the right
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 4) {
                    SimpleCircleView()
                    SimpleCircleView()
                    SimpleCircleView()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(hex: "#272727"))
            }
         
    }
}

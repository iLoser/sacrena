//
//  CustomFactory.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 15/09/24.
//

import Foundation
import SwiftUI
import StreamChat
import StreamChatSwiftUI



class CustomFactory: ViewFactory {
    
    @Injected(\.chatClient) public var chatClient
    @Injected(\.utils) public var utils
    
    private init() {}
    
     static let shared = CustomFactory()
    
    func makeChannelListHeaderViewModifier(title: String) -> some ChannelListHeaderViewModifier {
        CustomChannelModifier(title: "Connections")
    }
    
    func makeChannelHeaderViewModifier(for channel: ChatChannel) -> some ChatChannelHeaderViewModifier {
        return CustomChatChannelHeaderModifier(channel: channel)
        
    }
    
     func makeChannelListTopView(searchText: Binding<String>) -> some View {
        EmptyView()
    }
    
    func makeChannelListDividerItem() -> some View  {
        CustomListRowSeparator()
    }
    
    func makeChannelListItem(
            channel: ChatChannel,
            channelName: String,
            avatar: UIImage,
            onlineIndicatorShown: Bool,
            disabled: Bool,
            selectedChannel: Binding<ChannelSelectionInfo?>,
            swipedChannelId: Binding<String?>,
            channelDestination: @escaping (ChannelSelectionInfo) -> ChatChannelView<CustomFactory>,
            onItemTap:  @escaping (ChatChannel) -> Void,
            trailingSwipeRightButtonTapped: @escaping (ChatChannel) -> Void,
            trailingSwipeLeftButtonTapped: @escaping (ChatChannel) -> Void,
            leadingSwipeButtonTapped: @escaping (ChatChannel) -> Void
    ) -> some View {
        let listItem = Sacrena_DemoChatChannelNavigatableListItem(
            channel: channel,
            channelName: channelName,
            avatar: avatar,
            onlineIndicatorShown: onlineIndicatorShown,
            disabled: disabled,
            selectedChannel: selectedChannel,
            channelDestination: channelDestination,
            onItemTap: onItemTap
        )
        return ChatChannelSwipeableListItem(
            factory: self,
            channelListItem: listItem,
            swipedChannelId: swipedChannelId,
            channel: channel,
            numberOfTrailingItems: channel.ownCapabilities.contains(.deleteChannel) ? 2 : 1,
            trailingRightButtonTapped: trailingSwipeRightButtonTapped,
            trailingLeftButtonTapped: trailingSwipeLeftButtonTapped,
            leadingSwipeButtonTapped: leadingSwipeButtonTapped
        )
    }
    
    func makeComposerViewModifier() -> some ViewModifier {
        BackgroundViewModifier()
    }
    
    func makeLeadingComposerView(
        state: Binding<PickerTypeState>,
        channelConfig: ChannelConfig?
    ) -> some View {
        EmptyView()
    }

    func makeComposerInputView(
        text: Binding<String>,
        selectedRangeLocation: Binding<Int>,
        command: Binding<ComposerCommand?>,
        addedAssets: [AddedAsset],
        addedFileURLs: [URL],
        addedCustomAttachments: [CustomAttachment],
        quotedMessage: Binding<ChatMessage?>,
        maxMessageLength: Int?,
        cooldownDuration: Int,
        onCustomAttachmentTap: @escaping (CustomAttachment) -> Void,
        shouldScroll: Bool,
        removeAttachmentWithId: @escaping (String) -> Void
    ) -> some View {
        HStack(alignment: .bottom) {
            Button(action: {
                // Handle camera button tap here
            }) {
                Image(systemName: "camera")
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
            }
            
            TextField("", text: text, prompt: Text("  Message")
                .foregroundColor(.gray)
                .fontWeight(.thin)
            )
            .keyboardType(.default) // Set the keyboard type if needed
            .roundWithBorder()// Customize the text field style
            .frame(height: 50)
        }
    }
    
    func makeTrailingComposerView(
        enabled: Bool,
        cooldownDuration: Int,
        onTap: @escaping () -> Void
    ) -> some View {
        CustomSendMessageButton(enabled: enabled, onTap: onTap)
    }
    
}










//
//  ViewController.swift
//  Imgur
//
//  Created by Alexey Bukhtin on 14/08/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChatCore
import StreamChat
import Nuke
import SnapKit

class ViewController: ChatViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let channel = Channel(id: "general", name: "General")
        channelPresenter = ChannelPresenter(channel: channel)
        
        let backgroundColor = UIColor(red: 0.18, green: 0.19, blue: 0.21, alpha: 1)
        let imgurColor1 = UIColor(red: 0.35, green: 0.70, blue: 0.46, alpha: 1)
        let imgurColor2 = UIColor(red: 0.95, green: 0.71, blue: 0.26, alpha: 1)
        
        var style = ChatViewStyle.dark
        style.incomingMessage.replyColor = imgurColor1
        style.incomingMessage.chatBackgroundColor = backgroundColor
        style.incomingMessage.backgroundColor = .white
        style.incomingMessage.textColor = .black
        style.incomingMessage.borderWidth = 0
        style.incomingMessage.cornerRadius = 5
        style.outgoingMessage.replyColor = imgurColor1
        style.outgoingMessage.chatBackgroundColor = backgroundColor
        style.outgoingMessage.backgroundColor = imgurColor1
        style.outgoingMessage.textColor = .white
        style.outgoingMessage.borderWidth = 0
        style.outgoingMessage.cornerRadius = 5
        style.outgoingMessage.showCurrentUserAvatar = false
        style.composer.backgroundColor = backgroundColor
        style.composer.helperContainerBackgroundColor = backgroundColor
        style.composer.edgeInsets = .zero
        style.composer.cornerRadius = 0
        style.composer.height = 50
        style.composer.sendButtonVisibility = .always
        style.composer.states = [.active: .init(tintColor: imgurColor1),
                                 .edit: .init(tintColor: imgurColor2),
                                 .disabled: .init(tintColor: .chatGray)]
        self.style = style
        
        setupAttachmentsButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composerView.setSendButtonTitle("Send")
        addLinesToComposerView()
    }
    
    func setupAttachmentsButton() {
        ImagePipeline.Configuration.isAnimatedImageDataEnabled = true
        
        // Create a menu item for attachments.
        let selectGoose: ComposerAddFileType = .custom(icon: nil, title: "Goose dance with pigeons", .custom("custom1"), { _ in
            
            // Here open your picker view controller and select some image.
            
            // For example, let's select some image.
            let imageURL = URL(string: "https://i.imgur.com/zQheoDj.gif")!
            
            // Load preview.
            ImagePipeline.shared.loadImage(with: imageURL, completion: { result in
                guard let response = try? result.get() else {
                    return
                }
                
                // This is the most important part.
                // You can skip using attachments menu from ComposerView (just set `composerAddFileTypes = []`) and use own buttons.
                // Here an example how to add some exists URL to the ComposerView.
                
                // Create an attachment with already exists URL.
                let attachment = Attachment(type: .imgur,
                                            title: "Goose dance with pigeons",
                                            url: imageURL,
                                            imageURL: imageURL)
                
                /// Add the attachment to the composer.
                self.composerView.addImageUploaderItem(UploaderItem(attachment: attachment,
                                                                    previewImage: response.image,
                                                                    previewImageGifData: response.image.animatedImageData))
            })
            
            self.hideAddFileView()
            
        })
        
        // The same actions for the Star Wars.
        let selectStarWars: ComposerAddFileType = .custom(icon: nil, title: "Star Wars", .custom("custom2"), { _ in
            let imageURL = URL(string: "https://i.imgur.com/zN5umvX.gif")!
            
            ImagePipeline.shared.loadImage(with: imageURL, completion: { result in
                guard let response = try? result.get() else {
                    return
                }
                
                let attachment = Attachment(type: .imgur,
                                            title: "Star Wars",
                                            url: imageURL,
                                            imageURL: imageURL)
                
                self.composerView.addImageUploaderItem(UploaderItem(attachment: attachment,
                                                                    previewImage: response.image,
                                                                    previewImageGifData: response.image.animatedImageData))
            })
            
            self.hideAddFileView()
        })
        
        composerAddFileTypes = [selectGoose, selectStarWars]
    }
}

extension ViewController {
    func addLinesToComposerView() {
        let lineTopView = UIView(frame: .zero)
        let lineBottomView = UIView(frame: .zero)
        lineTopView.backgroundColor = UIColor(white: 0.13, alpha: 1)
        lineBottomView.backgroundColor = lineTopView.backgroundColor
        composerView.addSubview(lineTopView)
        composerView.addSubview(lineBottomView)
        
        lineTopView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(2)
        }
        
        lineBottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}

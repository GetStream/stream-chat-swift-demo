//
//  ViewController.swift
//  ChatDemo
//
//  Created by Stream on 10/07/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChatCore
import StreamChat
import Nuke
import SnapKit
import RxSwift
import RxCocoa

class ViewController: ChatViewController {
    
    let sendButton = UIButton(type: .custom)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let channel = Channel(type: .messaging, id: "general", name: "General")
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
        style.composer.edgeInsets = .init(top: 0, left: 0, bottom: 50, right: 0)
        style.composer.cornerRadius = 0
        style.composer.height = 50
        style.composer.sendButtonVisibility = .none
        style.composer.states = [.active: .init(tintColor: imgurColor1),
                                 .edit: .init(tintColor: imgurColor2),
                                 .disabled: .init(tintColor: .chatGray)]
        self.style = style
        
        // This is the most important part.
        // You can skip using attachments menu from ComposerView (just set `composerAddFileTypes = []`) and use own buttons.
        // Here an example how to add some exists URL to the ComposerView.
        setupAttachmentsButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLinesToComposerView()
        addCustomButton()
        addCustomSendButton()
    }
    
    func setupAttachmentsButton() {
        ImagePipeline.Configuration.isAnimatedImageDataEnabled = true
        
        // Create a menu item for attachments.
        let selectGoose: ComposerAddFileType = .custom(icon: nil, title: "Goose dance with pigeons", .custom("custom1"), { _ in
            // Here open your picker view controller and select some image.
            self.select(url: URL(string: "https://i.imgur.com/zQheoDj.gif")!, title: "Goose dance with pigeons")
            self.hideAddFileView()
        })
        
        // The same actions for the Star Wars.
        let selectStarWars: ComposerAddFileType = .custom(icon: nil, title: "Star Wars", .custom("custom2"), { _ in
            // Here open your picker view controller and select some image.
            self.select(url: URL(string: "https://i.imgur.com/zN5umvX.gif")!, title: "Star Wars")
            self.hideAddFileView()
        })
        
        composerAddFileTypes = [selectGoose, selectStarWars]
    }
    
    func select(url: URL, title: String) {
        // Load preview.
        ImagePipeline.shared.loadImage(with: url, completion: { result in
            guard let response = try? result.get() else {
                return
            }
            
            // Create an attachment with already exists URL.
            let attachment = Attachment(type: .imgur,
                                        title: title,
                                        url: url,
                                        imageURL: url)
            
            /// Add the attachment to the composer.
            self.composerView.addImageUploaderItem(UploaderItem(attachment: attachment,
                                                                previewImage: response.image,
                                                                previewImageGifData: response.image.animatedImageData))
        })
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
    
    func addCustomButton() {
        let button = UIButton(type: .custom)
        button.setTitle("🐷", for: .normal)
        view.addSubview(button)
        
        // Button layout:
        // left = superview
        // top = ComposerView.bottom
        // size = 50
        button.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(composerView.snp.bottom)
            make.width.height.equalTo(50)
        }
        
        button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.select(url: URL(string: "https://i.imgur.com/xCSs2rQ.gif")!, title: "Pig dance")
            })
            .disposed(by: disposeBag)
        
        addBottomBackgroundViewForCustomButton(button)
    }
    
    func addBottomBackgroundViewForCustomButton(_ button: UIButton) {
        let view = UIView(frame: .zero)
        view.backgroundColor = self.view.backgroundColor
        self.view.insertSubview(view, belowSubview: button)
        
        view.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(button.snp.top)
        }
    }
    
    func addCustomSendButton() {
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitleColor(.gray, for: .disabled)
        sendButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(composerView.snp.bottom)
        }
        
        // React on visibility state of the sendButton.
        composerView.sendButtonVisibility
            .subscribe(onNext: { [weak self] visibility in self?.sendButton.isEnabled = visibility.isEnabled })
            .disposed(by: disposeBag)
        
        // Send a message.
        sendButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.send() })
            .disposed(by: disposeBag)
    }
}

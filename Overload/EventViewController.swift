//
//  EventViewController.swift
//  Overload
//
//  Created by Draveness on 11/13/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class EventViewController: UIViewController {

    // MAKR: - Function

    let functionView = UIView().then {
        $0.backgroundColor = UIColor.white
    }

    let checkoutButton = UIButton().then {
        $0.backgroundColor = UIColor(hex: 0x00AF9E)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setTitle("去下单", for: .normal)
        $0.layer.cornerRadius = 7
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
        $0.clipsToBounds = true
    }

    let borderLineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }

    let detailView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xf7f7f7)
    }

    let introPromptLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        $0.text = "故事简介"
        $0.textColor = UIColor.darkGray
    }

    let lineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
        $0.layer.cornerRadius = 1.5
        $0.clipsToBounds = true
    }

    let introLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        $0.text = "· 4 折 Eleme 独享 填满主厨爱意\n· 进口食材 米其林大厨烹制\n· 极尽奢华 畅想极佳外卖体验"
        $0.textColor = UIColor.lightGray.darkened()
        $0.numberOfLines = 0
    }

    var event: Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: 0xf7f7f7)

        title = event.title
        introLabel.text = event.text
        let player = AVPlayer(url: event.videoURL)
        let playerController = AVPlayerViewController()

        playerController.player = player
        addChildViewController(playerController)

        view.addSubview(playerController.view)

        view.addSubview(detailView)
        detailView.addSubview(introPromptLabel)
        detailView.addSubview(lineView)
        detailView.addSubview(introLabel)

        view.addSubview(functionView)
        functionView.addSubview(checkoutButton)
        functionView.addSubview(borderLineView)

        playerController.view.frame = self.view.frame

        playerController.view.snp.makeConstraints { (make) in
            make.left.top.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(210)
        }

        functionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }

        checkoutButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 40))
        }

        borderLineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }

        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(playerController.view.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(400)
        }

        introPromptLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(24)
        }

        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(introPromptLabel.snp.bottom).offset(9)
            make.height.equalTo(3)
            make.width.equalTo(introPromptLabel)
        }

        introLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(lineView.snp.bottom).offset(15)
        }

        checkoutButton.addTarget(self, action: #selector(pushMenuViewController), for: .touchUpInside)
    }

    func pushMenuViewController() {
        let menuVC = MenuCollectionViewController()
        menuVC.keyword = event.keyword
        navigationController?.pushViewController(menuVC, animated: true)
    }

}

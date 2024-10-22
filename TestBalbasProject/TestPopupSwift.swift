//
//  TestPopupSwift.swift
//  TestBalbasProject
//
//  Created by 平野裕貴 on 2024/10/22.
//

import UIKit

// TestPopupSwiftViewController: 全画面表示のビュー
class TestPopupSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景色を白に設定
        self.view.backgroundColor = .white

        // ポップアップ表示ボタンを追加
        let showPopupButton = UIButton(type: .system)
        showPopupButton.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        showPopupButton.setTitle("ポップアップを表示", for: .normal)
        showPopupButton.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        self.view.addSubview(showPopupButton)
    }

    // ポップアップを表示する処理
    @objc func showPopup() {
        let popupVC = TestPopupSwiftView()
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        self.present(popupVC, animated: true, completion: nil)
    }
}


// ポップアップとして表示するビュー
class TestPopupSwiftView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景を半透明に設定
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        // ポップアップのサイズと位置を設定
        let popupWidth = self.view.frame.width * 0.8
        let popupHeight = self.view.frame.height * 0.4
        let popupView = UIView(frame: CGRect(x: (self.view.frame.width - popupWidth) / 2,
                                             y: (self.view.frame.height - popupHeight) / 2,
                                             width: popupWidth,
                                             height: popupHeight))

        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 10

        // 画面サイズラベルを追加
        let screenHeightLabel = UILabel(frame: CGRect(x: 10, y: 10, width: popupWidth - 20, height: 30))
        screenHeightLabel.text = "画面の縦幅: \(Int(self.view.frame.height))"
        screenHeightLabel.textAlignment = .center
        popupView.addSubview(screenHeightLabel)

        let screenWidthLabel = UILabel(frame: CGRect(x: 10, y: 50, width: popupWidth - 20, height: 30))
        screenWidthLabel.text = "画面の横幅: \(Int(self.view.frame.width))"
        screenWidthLabel.textAlignment = .center
        popupView.addSubview(screenWidthLabel)

        // 閉じるボタンを中央に配置
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("閉じる", for: .normal)
        closeButton.setTitleColor(.blue, for: .normal)
        closeButton.frame = CGRect(x: (popupWidth - 100) / 2, y: popupHeight - 60, width: 100, height: 50)
        closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)

        popupView.addSubview(closeButton)

        // ポップアップビューを画面に追加
        self.view.addSubview(popupView)
    }

    // ポップアップを閉じる処理
    @objc func closePopup() {
        self.dismiss(animated: true, completion: nil)
    }
}

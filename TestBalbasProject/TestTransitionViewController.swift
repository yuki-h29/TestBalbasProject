//
//  TestTransitionViewController.swift
//  TestBalbasProject
//
//  Created by 平野裕貴 on 2024/10/25.
//

import UIKit

/// 遷移方法確認(遷移元のView)
class TestTransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // ナビゲーションバーに「閉じる」ボタンを追加
        let closeButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(closeModal))
        navigationItem.leftBarButtonItem = closeButton  // 左側に配置
        
        // モーダル遷移ボタン（FullScreen）
        let fullScreenButton = createButton(title: "FullScreenで遷移", yPosition: 100)
        fullScreenButton.addTarget(self, action: #selector(fullScreenTransition), for: .touchUpInside)
        
        // モーダル遷移ボタン（PageSheet）
        let pageSheetButton = createButton(title: "PageSheetで遷移", yPosition: 170)
        pageSheetButton.addTarget(self, action: #selector(pageSheetTransition), for: .touchUpInside)
        
        // モーダル遷移ボタン（FormSheet）
        let formSheetButton = createButton(title: "FormSheetで遷移", yPosition: 240)
        formSheetButton.addTarget(self, action: #selector(formSheetTransition), for: .touchUpInside)
        
        // モーダル遷移ボタン（OverFullScreen）
        let overFullScreenButton = createButton(title: "OverFullScreenで遷移", yPosition: 310)
        overFullScreenButton.addTarget(self, action: #selector(overFullScreenTransition), for: .touchUpInside)
        
        // モーダル遷移ボタン（CurrentContext）
        let currentContextButton = createButton(title: "CurrentContextで遷移", yPosition: 380)
        currentContextButton.addTarget(self, action: #selector(currentContextTransition), for: .touchUpInside)
        
        // NavigationControllerで遷移（標準）
        let pushButton = createButton(title: "Pushで遷移", yPosition: 450)
        pushButton.addTarget(self, action: #selector(pushTransition), for: .touchUpInside)
        
        // NavigationControllerで遷移（ナビゲーションバー非表示）
        let pushWithoutNavButton = createButton(title: "Pushでナビバー非表示", yPosition: 520)
        pushWithoutNavButton.addTarget(self, action: #selector(pushWithoutNavigationBar), for: .touchUpInside)
        
        // NavigationControllerでカスタムアニメーション遷移
        let pushCustomAnimationButton = createButton(title: "Pushでカスタムアニメ", yPosition: 590)
        pushCustomAnimationButton.addTarget(self, action: #selector(pushWithCustomAnimation), for: .touchUpInside)
        
        view.addSubview(fullScreenButton)
        view.addSubview(pageSheetButton)
        view.addSubview(formSheetButton)
        view.addSubview(overFullScreenButton)
        view.addSubview(currentContextButton)
        view.addSubview(pushButton)
        view.addSubview(pushWithoutNavButton)
        view.addSubview(pushCustomAnimationButton)
    }
    
    // ボタン作成ヘルパー関数
    func createButton(title: String, yPosition: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.frame = CGRect(x: 50, y: yPosition, width: 250, height: 50)
        return button
    }

    // モーダル遷移のメソッド群
    @objc func fullScreenTransition() {
        let testVC2 = TestTransitionViewController2()
        testVC2.modalPresentationStyle = .fullScreen
        self.present(testVC2, animated: true, completion: nil)
    }

    @objc func pageSheetTransition() {
        let testVC2 = TestTransitionViewController2()
        testVC2.modalPresentationStyle = .pageSheet
        self.present(testVC2, animated: true, completion: nil)
    }

    @objc func formSheetTransition() {
        let testVC2 = TestTransitionViewController2()
        testVC2.modalPresentationStyle = .formSheet
        self.present(testVC2, animated: true, completion: nil)
    }

    @objc func overFullScreenTransition() {
        let testVC2 = TestTransitionViewController2()
        testVC2.modalPresentationStyle = .overFullScreen
        self.present(testVC2, animated: true, completion: nil)
    }

    @objc func currentContextTransition() {
        let testVC2 = TestTransitionViewController2()
        testVC2.modalPresentationStyle = .currentContext
        self.present(testVC2, animated: true, completion: nil)
    }

    // NavigationControllerでの標準的なプッシュ遷移
    @objc func pushTransition() {
        let testVC2 = TestTransitionViewController2()
        navigationController?.pushViewController(testVC2, animated: true)
    }

    // NavigationControllerでナビゲーションバーを非表示にして遷移
    @objc func pushWithoutNavigationBar() {
        let testVC2 = TestTransitionViewController2()
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(testVC2, animated: true)
    }

    // NavigationControllerでカスタムアニメーションの遷移
    @objc func pushWithCustomAnimation() {
        let testVC2 = TestTransitionViewController2()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromBottom
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(testVC2, animated: false)
    }
    
    @objc func closeModal() {
        // モーダルを閉じる処理
        self.dismiss(animated: true, completion: nil)
    }
}

/// 表示用のView
class TestTransitionViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        // 閉じるボタンを中央に配置
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("閉じる", for: .normal)
        closeButton.frame = CGRect(x: (view.frame.size.width - 100) / 2,
                                   y: (view.frame.size.height - 50) / 2,
                                   width: 100,
                                   height: 50)
        closeButton.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    @objc func closeViewController() {
        // Navigationでの遷移の場合はpop、それ以外はdismissで戻る
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

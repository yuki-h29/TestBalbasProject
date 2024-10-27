//
//  TestPopupView2.swift
//  TestBalbasProject
//
//  Created by 平野裕貴 on 2024/10/27.
//

import UIKit

class TestPopupView1_: UIViewController {

    var onComplete: (() -> Void)?

    private let popupView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupPopupView()
    }

    private func setupBackgroundView() {
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backgroundView)
    }

    private func setupPopupView() {
        popupView.backgroundColor = UIColor.purple
        popupView.layer.cornerRadius = 10
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)

        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            popupView.heightAnchor.constraint(equalToConstant: 600)
        ])

        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        popupView.addSubview(okButton)

        NSLayoutConstraint.activate([
            okButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            okButton.centerYAnchor.constraint(equalTo: popupView.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // スライドインアニメーションを適用　初期設定として必要
        CommonAnimation.animateSlideInFromRight(view: popupView, fromViewController: self)
    }

    @objc private func okButtonTapped() {
        // TestPopupView2_を表示する処理
        let popup2 = TestPopupView2_()
        CommonAnimation.presentPopup(currentViewController: self, nextPopup: popup2)

        // TestPopupView2が閉じられた際に自分を閉じる処理
        popup2.onComplete = { [weak self] in
            guard let self = self else { return }
            
            // 右にスライドしてポップアップを閉じる
            CommonAnimation.animateSlideOutToRight(view: self.popupView, fromViewController: self) {
                // アニメーション終了後にポップアップを閉じる
                self.dismiss(animated: false, completion: {
                    self.onComplete?()  // 遷移元(ViewController)に完了通知を送る
                })
            }
        }
    }
}




class TestPopupView2_: UIViewController {

    var onComplete: (() -> Void)?

    private let popupView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupPopupView()
    }

    private func setupBackgroundView() {
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backgroundView)
    }

    private func setupPopupView() {
        popupView.backgroundColor = UIColor.systemPink
        popupView.layer.cornerRadius = 10
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)

        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: view.bounds.width - 40),
            popupView.heightAnchor.constraint(equalToConstant: 400)
        ])

        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        popupView.addSubview(okButton)

        NSLayoutConstraint.activate([
            okButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            okButton.centerYAnchor.constraint(equalTo: popupView.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // スライドインアニメーションを適用　初期設定として必要
        CommonAnimation.animateScaleIn(view: popupView)
    }

    @objc private func okButtonTapped() {
        // TestPopupView3_を表示する処理
        let popup3 = TestPopupView3_()
        CommonAnimation.presentPopup(currentViewController: self, nextPopup: popup3)

        // TestPopupView3_が閉じられた際に自分を閉じる処理
        popup3.onComplete = { [weak self] in
            guard let self = self else { return }
            
            // スケールアウトしてポップアップを閉じる
            CommonAnimation.animateScaleOut(view: self.popupView, duration: 0.3) {
                // アニメーション終了後にポップアップを閉じる
                self.dismiss(animated: false, completion: {
                    self.onComplete?()  // 遷移元(TestPopupView1_)に完了通知を送る
                })
            }
        }
    }
}


class TestPopupView3_: UIViewController {

    var onComplete: (() -> Void)?

    private let popupView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupPopupView()
    }

    private func setupBackgroundView() {
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backgroundView)
    }

    private func setupPopupView() {
        popupView.backgroundColor = UIColor.white
        popupView.layer.cornerRadius = 10
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)

        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: view.bounds.width - 80),
            popupView.heightAnchor.constraint(equalToConstant: 200)
        ])

        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        popupView.addSubview(okButton)

        NSLayoutConstraint.activate([
            okButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            okButton.centerYAnchor.constraint(equalTo: popupView.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // スライドインアニメーションを適用　初期設定として必要
        CommonAnimation.animateFadeIn(view: popupView)
    }
    
    @objc private func okButtonTapped() {
        // スケールアウトしてポップアップを閉じる
        CommonAnimation.animateFadeOut(view: self.popupView, duration: 0.3) {
            // アニメーション終了後にポップアップを閉じる
            self.dismiss(animated: false, completion: {
                self.onComplete?()  // 遷移元(TestPopupView2_)に完了通知を送る
            })
        }
    }
}

/// Popupの表示時のアニメーションを管理するクラス
class CommonAnimation {
    
    // ポップアップをスライドインする（下から）
    static func animateSlideIn(view: UIView, fromViewController vc: UIViewController, completion: (() -> Void)? = nil) {
        view.transform = CGAffineTransform(translationX: 0, y: vc.view.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = .identity
        }, completion: { _ in
            completion?()
        })
    }
    
    // ポップアップをスライドアウトする（下へ）
    static func animateSlideOut(view: UIView, fromViewController vc: UIViewController, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(translationX: 0, y: vc.view.frame.height)
        }, completion: { _ in
            completion()
        })
    }

    // ポップアップを横にスライドインする（右から）
    static func animateSlideInFromRight(view: UIView, fromViewController vc: UIViewController, completion: (() -> Void)? = nil) {
        view.transform = CGAffineTransform(translationX: vc.view.frame.width, y: 0)
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = .identity
        }, completion: { _ in
            completion?()
        })
    }
    
    // ポップアップを横にスライドアウトする（右へ）
    static func animateSlideOutToRight(view: UIView, fromViewController vc: UIViewController, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(translationX: vc.view.frame.width, y: 0)
        }, completion: { _ in
            completion()
        })
    }

    // フェードインアニメーション
    static func animateFadeIn(view: UIView, duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        view.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }

    // フェードアウトアニメーション
    static func animateFadeOut(view: UIView, duration: TimeInterval = 0.3, completion: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }, completion: { _ in
            completion()
        })
    }

    // スケールインアニメーション（拡大しながら表示）
    static func animateScaleIn(view: UIView, duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: duration, animations: {
            view.transform = .identity
        }, completion: { _ in
            completion?()
        })
    }

    // スケールアウトアニメーション（縮小しながら非表示）
    static func animateScaleOut(view: UIView, duration: TimeInterval = 0.3, completion: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: { _ in
            completion()
        })
    }
    
    // 共通のポップアップ表示処理
    static func presentPopup(currentViewController: UIViewController, nextPopup: UIViewController, completion: (() -> Void)? = nil) {
        nextPopup.modalPresentationStyle = .overCurrentContext
        currentViewController.present(nextPopup, animated: false, completion: completion)
    }

    // ポップアップを閉じる処理
    static func closePopup(viewController: UIViewController, popupView: UIView, completion: @escaping () -> Void) {
        animateSlideOut(view: popupView, fromViewController: viewController) {
            viewController.dismiss(animated: false, completion: {
                completion()
            })
        }
    }
}

//
//  TestPopupView.swift
//  TestBalbasProject
//
//  Created by 平野裕貴 on 2024/10/26.
//　順番にクロージャを使ってポップアップを順番に閉じていく

import UIKit

class TestPopupView1: UIViewController {

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
        
        // ポップアップを画面下端よりも外側に初期位置を設定（画面の高さ分だけ下に移動）
        popupView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
        // ポップアップをスライドイン（元の位置へ移動）
        UIView.animate(withDuration: 0.3) {
            self.popupView.transform = .identity
            self.view.layoutIfNeeded()
        }
    }

    @objc private func okButtonTapped() {
        // TestPopupView2 を重ねて表示
        let popup2 = TestPopupView2()
        popup2.modalPresentationStyle = .overCurrentContext

        // TestPopupView2が閉じられた際に、自分も閉じるようにする　■■■completion{}に実行後に行う処理を記載する
        popup2.onComplete = { [weak self] in
            self?.animateClose {
                self?.dismiss(animated: false, completion: {
                    self?.onComplete?()  // 遷移元(ViewController)に完了通知
                })
            }
        }
        present(popup2, animated: false, completion: nil)
    }

    // 閉じるアニメーション（画面外にスライド）
    private func animateClose(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            // ポップアップを画面外（下端よりも下）に移動
            self.popupView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }, completion: { _ in
            completion()
        })
    }
}




class TestPopupView2: UIViewController {

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
        
        // ポップアップを画面下端よりも外側に初期位置を設定（画面の高さ分だけ下に移動）
        popupView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
        // ポップアップをスライドイン（元の位置へ移動）
        UIView.animate(withDuration: 0.3) {
            self.popupView.transform = .identity
            self.view.layoutIfNeeded()
        }
    }

    @objc private func okButtonTapped() {
        // TestPopupView3 を重ねて表示
        let popup3 = TestPopupView3()
        popup3.modalPresentationStyle = .overCurrentContext

        // TestPopupView3が閉じられた際に、自分も閉じるようにする ■■■completion{}に実行後に行う処理を記載する
        popup3.onComplete = { [weak self] in
            self?.animateClose {
                self?.dismiss(animated: false, completion: {
                    self?.onComplete?()  // 遷移元(TestPopupView2)に完了通知
                })
            }
        }
        present(popup3, animated: false, completion: nil)
    }

    // 閉じるアニメーション（画面外にスライド）
    private func animateClose(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            // ポップアップを画面外（下端よりも下）に移動
            self.popupView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }, completion: { _ in
            completion()
        })
    }
}


class TestPopupView3: UIViewController {

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
        
        // ポップアップを画面下端よりも外側に初期位置を設定（画面の高さ分だけ下に移動）
        popupView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
        // ポップアップをスライドイン（元の位置へ移動）
        UIView.animate(withDuration: 0.3) {
            self.popupView.transform = .identity
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func okButtonTapped() {
        // 自分を閉じて、上に通知　■■■completion{}に実行後に行う処理を記載する
        animateClose {
            self.dismiss(animated: false, completion: {
                self.onComplete?()  // 遷移元(TestPopupView2)に完了通知
            })
        }
    }

    // 閉じるアニメーション（画面外にスライド）
    private func animateClose(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            // ポップアップを画面外（下端よりも下）に移動
            self.popupView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }, completion: { _ in
            completion()
        })
    }
}

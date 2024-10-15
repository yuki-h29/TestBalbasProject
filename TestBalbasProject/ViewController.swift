import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
    }
    
    // 10個のボタンを配置する関数
    func setupButtons() {
        for i in 1...10 {
            let button = UIButton(type: .system)
            button.setTitle("Button \(i)", for: .normal)
            button.tag = i
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            view.addSubview(button)
            
            // ボタンの制約を設定
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(50 + i * 40)),
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    // ボタンが押された時に呼ばれる関数
    @objc func buttonTapped(_ sender: UIButton) {
        let buttonIndex = sender.tag
        print("Button \(buttonIndex) tapped")
        
        if buttonIndex == 9 {
            displaySwiftUIViewWithPopup()
        } else if buttonIndex == 10 {
            displaySwiftUIView()
        }
    }
    
    // ボタン9用のSwiftUIのビューを表示し、ポップアップボタンを含むビューを表示する
    func displaySwiftUIViewWithPopup() {
        let swiftUIView = TestPopupSwiftUI()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
    // SwiftUIのビューを表示する関数
    func displaySwiftUIView() {
        // ランダムなデータを生成
        let randomData = generateRandomUserData()

        // TestSwiftUI を生成し、ランダムデータを渡す
        let swiftUIView = TestSwiftUI(userData: randomData)

        // UIHostingController で SwiftUI を表示
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // HostingController を子ビューコントローラとして追加
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        // HostingController のビューに制約を設定
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }

    // ランダムな UserData を生成する関数
    func generateRandomUserData() -> [UserData] {
        let userNames = ["John", "Jane", "Tom", "Alice", "Bob"]
        let subjects = ["Subject 1", "Subject 2", "Subject 3", "Subject 4", "Subject 5"]
        let messages = [
            "This is message 1.",
            "This is message 2.",
            "This is message 3.",
            "This is message 4.",
            "This is message 5."
        ]
        
        var randomData = [UserData]()
        for i in 0..<userNames.count {
            let randomUser = UserData(
                userID: String(i + 1),
                userName: userNames[Int.random(in: 0..<userNames.count)],
                subject: subjects[Int.random(in: 0..<subjects.count)],
                message: messages[Int.random(in: 0..<messages.count)]
            )
            randomData.append(randomUser)
        }
        return randomData
    }
}

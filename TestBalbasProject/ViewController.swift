import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

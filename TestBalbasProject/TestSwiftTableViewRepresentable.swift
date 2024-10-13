import SwiftUI

struct TestSwiftTableViewRepresentable: UIViewControllerRepresentable {
    var userData: [UserData]  // データをプロパティとして保持
    
    func makeUIViewController(context: Context) -> TestSwiftTableView {
        let viewController = TestSwiftTableView()
        viewController.userDataList = userData  // データを設定
        return viewController
    }

    func updateUIViewController(_ uiViewController: TestSwiftTableView, context: Context) {
        // 必要に応じてデータを更新
    }
}

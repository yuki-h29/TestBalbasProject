import SwiftUI

struct TestSwiftUI: View {
    var userData: [UserData]  // 動的データを受け取る
    
    var body: some View {
        VStack {
            Text("Test SwiftUI with TableView")
                .font(.largeTitle)
                .padding()

            TestSwiftTableViewRepresentable(userData: userData)  // データを渡す
                .edgesIgnoringSafeArea(.all)
        }
    }
}

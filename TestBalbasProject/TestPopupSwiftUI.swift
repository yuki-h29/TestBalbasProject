import SwiftUI

struct TestPopupSwiftUI: View {
    @State private var isPopupPresented = false
    @State private var animationType: AnimationType = .scale
    @State private var rotationAngle: Double = 0 // 回転角度を管理する状態

    enum AnimationType {
        case scale, opacity, slideDefault, slideRight, rotate
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("SwiftUI Popup Test")
                    .font(.title)
                    .padding()

                // デフォルトのスライドアニメーション（左から出て右に消える）
                Button("Show Default Slide Animation Popup") {
                    withAnimation {
                        animationType = .slideDefault
                        isPopupPresented = true
                    }
                }
                .font(.headline)
                .padding()

                // 右からスライドして右に消える
                Button("Show Right Slide Animation Popup") {
                    withAnimation {
                        animationType = .slideRight
                        isPopupPresented = true
                    }
                }
                .font(.headline)
                .padding()

                // 回転アニメーション
                Button("Show Rotate Animation Popup") {
                    withAnimation {
                        animationType = .rotate
                        rotationAngle = 90 // 回転開始角度を設定
                        isPopupPresented = true
                    }
                }
                .font(.headline)
                .padding()

                // 他のアニメーション用ボタン
                Button("Show Scale Animation Popup") {
                    withAnimation {
                        animationType = .scale
                        isPopupPresented = true
                    }
                }
                .font(.headline)
                .padding()
                
                Button("Show Opacity Animation Popup") {
                    withAnimation {
                        animationType = .opacity
                        isPopupPresented = true
                    }
                }
                .font(.headline)
                .padding()
            }
            
            // ポップアップ表示
            if isPopupPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                
                // ポップアップ部分を別のViewに分離
                PopupView(isPopupPresented: $isPopupPresented, animationType: animationType, rotationAngle: $rotationAngle)
                    .transition(transitionForAnimationType(animationType)) // transitionを直接使用
            }
        }
    }
    
    // アニメーションの種類に応じた transition を返す関数
    private func transitionForAnimationType(_ type: AnimationType) -> AnyTransition {
        switch type {
        case .scale:
            return .scale
        case .opacity:
            return .opacity
        case .slideDefault:
            return .slide
        case .slideRight:
            return slideFromRight()
        case .rotate:
            return .identity // 回転は別途 `rotationEffect` で管理
        }
    }
    
    // 右から入って右に画面外へ消えるスライドアニメーション
    private func slideFromRight() -> AnyTransition {
        let screenWidth = UIScreen.main.bounds.width
        return AnyTransition.asymmetric(
            insertion: AnyTransition.offset(x: screenWidth), // 右から入る
            removal: AnyTransition.offset(x: screenWidth) // 右に画面外へ消える
        )
    }
}



struct PopupView: View {
    @Binding var isPopupPresented: Bool
    var animationType: TestPopupSwiftUI.AnimationType
    @Binding var rotationAngle: Double
    
    var body: some View {
        VStack {
            Text("This is a Popup!")
                .font(.headline)
                .padding()
            
            Button("Close Popup") {
                withAnimation {
                    isPopupPresented = false
                }
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .rotationEffect(.degrees(rotationAngle)) // 回転アニメーションを適用
        .onAppear {
            if animationType == .rotate {
                withAnimation(.easeInOut(duration: 1)) {
                    rotationAngle = 0 // アニメーションで回転角度を元に戻す
                }
            }
        }
    }
}

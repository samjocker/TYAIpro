//
//  ContentView.swift
//  ShinherPRO
//
//  Created by 江祐鈞(Sam) on 2023/7/22.
//

import SwiftUI

class LoginPageViewModel: ObservableObject {
    @Published var isLoading = false
}

struct ContentView: View {
    @State var changeToMain = false
    var body: some View {
        ZStack {
            MainPage()
                .opacity(changeToMain ? 1 : 0)
                .animation(.easeInOut(duration: 0.7), value: changeToMain)

            LoginPage(changeToMain: self.$changeToMain)
                .opacity(changeToMain ? 0 : 1)
                .offset(y: changeToMain ? -UIScreen.main.bounds.height : 0)
                .animation(.easeInOut(duration: 0.7), value: changeToMain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


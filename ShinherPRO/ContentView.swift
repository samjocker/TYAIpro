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
    @State var gradeDataTitle:[String] = [""]
    @State var gradeDataScore:[String] = [""]
    @State var gradeDataTotal:String = ""
//    @State var gradeData:[String:[String]] = ["title":[],"score":[],"total":[]]
    var body: some View {
        ZStack {
            TabView{
                MainPage(gradeDataTitle:$gradeDataTitle,gradeDataScore: $gradeDataScore,gradeDataTotal: $gradeDataTotal)
                    .opacity(changeToMain ? 1 : 0)
                    .animation(.easeInOut(duration: 0.7), value: changeToMain)
                    .tabItem{
                        Image(systemName: "square.text.square.fill")
                    }
            }
            LoginPage(changeToMain: self.$changeToMain, gradeDataTitle:$gradeDataTitle,gradeDataScore:$gradeDataScore,gradeDataTotal:$gradeDataTotal)
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


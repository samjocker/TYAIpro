//
//  LoginPage.swift
//  ShinherPRO
//
//  Created by 江祐鈞 on 2023/7/29.
//

import SwiftUI

private enum InputBox{
    case studentIdBox,passwordBox
}

struct LoginPage: View{
    @Environment(\.colorScheme) var colorScheme
    @Binding var changeToMain:Bool
    @State private var studentID = ""
    @State private var password = ""
    @State private var userAgree = false
    @State private var loginPass = false
    @State private var loginFalse = false
    @State private var loginFalseReason = ""
    @State private var isEditingID = false
    @State private var isEditingPassword = false
    @FocusState private var box: InputBox?
    @ObservedObject var viewModel = LoginPageViewModel()
    @Binding var gradeDataTitle:[String]
    @Binding var gradeDataScore:[String]
    
    var body: some View {

        GeometryReader{ geo in
            ZStack{
                VStack {
                    HStack{
                        Text("TYAI ")
                            .fontWeight(.bold)
                            .font(.system(size: 40, design: .rounded))
                        ZStack{
                            RoundedRectangle(cornerRadius:15)
                                .fill(.orange)
                                .frame(width: 95,height: 50)
                            Text("PRO")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 40, design: .rounded))
                        }
                        
                    }.blur(radius: isEditingID || isEditingPassword ? 10 : 0)
                    .padding(.top,geo.size.height>1000 ? 200:0)
                    .animation(.easeInOut(duration: 1))
                    Spacer()
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 40)
                            .fill((colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white).shadow(.drop(color:.secondary.opacity(0.3),radius: 20,x: 1,y:1)))
                            .frame(width: 340,height: 500)
                        //                    .position(x: 180,y: 400)
                        VStack{
                            Image("GoogleLogo")
                                .padding(.top,-140)
//                            Image("TYAIlogoShining")
//                                .padding(.top,-140)
                            Text("登錄帳號")
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                                .font(.system(size: 35))
                                .padding(.bottom,20)
                            TextField("學號",text: $studentID, onEditingChanged: { editing in
                                isEditingID = editing
                            })
                                .padding()
                                .frame(width: 300, height: 60)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.04))
                                .cornerRadius(CGFloat(18))
                                .submitLabel(.continue)
                                .focused($box,equals: .studentIdBox)
                                .onSubmit {
                                    box = .passwordBox
                                }
                                .keyboardType(.numbersAndPunctuation)
                            
                            
                            SecureField("密碼",text: $password,onCommit: {
                                isEditingPassword = false
                            })
                                .onTapGesture {
                                    isEditingPassword = true
                                }
                                .padding()
                                .frame(width: 300, height: 60)
                                .background(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.04))
                                .cornerRadius(CGFloat(18))
                                .submitLabel(.done)
                                .focused($box,equals: .passwordBox)
                                .keyboardType(.asciiCapable)
//                                .onSubmit {
//                                    box = .passwordBox
//                                }
                            
                            Toggle(isOn: $userAgree) {
                                HStack{
                                    Text("我同意")
                                    Button("用戶使用條款"){
                                    }
                                }
                            }.padding(.horizontal,geo.size.width/2-160).padding(.top,10)
                            
                            Button(action: {
                                loginCustom(userName : studentID, userPassword : password)
                            }) {
                                Text("登錄")
                                    .foregroundColor(Color.white)
                                    .frame(width: 300,height: 60)
                                    .background(.blue)
                                    .cornerRadius(CGFloat(18))
                                    .font(Font.system(size: 25))
                                    .padding(.vertical,10)
                                    .alert(loginFalseReason,isPresented: $loginFalse){
                                        Button("確定", role: .cancel) { }
                                    }
                            }
                            
                        }
                    }.padding(.bottom,geo.size.height>1000 ? 200:0)
                    
                }
                .padding()
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom,130)
                } else {
                    Button(action: {
                        loginCustom(userName : studentID, userPassword : password)
                    }) {
                        
                    }
                }
            }.scrollDismissesKeyboard(.immediately)
        }
    }
    struct APIResponse: Codable {
        let code: Int
        let name: String
        let id: String
        let average: String
        let rank: String
        let classValue: String
        let subjectRank: String
        let total: String
        let examTitle: String
        let examScores: [ExamScore]
        

        enum CodingKeys: String, CodingKey {
            case code = "code"
            case name = "姓名"
            case id = "學號"
            case average = "平均"
            case rank = "排名"
            case classValue = "班級"
            case subjectRank = "科別排名"
            case total = "總分"
            case examTitle = "考試標題"
            case examScores = "考試科目成績"
        }
    }

    struct ExamScore: Codable {
        let personalScore: String
        let classAverage: String
        let examSubject: String

        enum CodingKeys: String, CodingKey {
            case personalScore = "個人成績"
            case classAverage = "全班平均"
            case examSubject = "考試科目"
        }
    }

    
    func loginCustom(userName: String, userPassword: String) {

        if userName == "" || userPassword == "" {
            loginFalse = true
            loginFalseReason = "帳密不得為空"
        } else {
            if userAgree == true {
                guard let url = URL(string: "https://00a4-61-220-172-18.ngrok-free.app/developer?userinput=\(userName)s\(userPassword)") else { return }

                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                viewModel.isLoading = true

                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    viewModel.isLoading = false
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        do {
                            // 使用 JSONDecoder 來解析數據
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(APIResponse.self, from: data)
                            
                            // 檢查 "code" 是否為 0，如果是則視為登入成功
                            if response.code == 0 {
                                DispatchQueue.main.async {
                                    gradeDataScore = []
                                    gradeDataTitle = []
                                    for score in response.examScores {
                                        gradeDataTitle.append(score.examSubject)
                                        gradeDataScore.append(score.personalScore)
//                                        print(gradeDataTitle)
//                                        print(gradeDataScore)
//                                        print(gradeTitle)
//                                        print(score.examSubject)
                                    }
                                }
                                self.loginPass = true
                                changeToMain = true
                            } else {
                                DispatchQueue.main.async {
                                    self.loginFalse = true
                                    self.loginFalseReason = "帳號或密碼錯誤"
                                }
                            }
                        } catch {
                            print("Error decoding the data: \(error)")
                        }
                    }
                }

                task.resume()
            } else {
                loginFalse = true
                loginFalseReason = "請同意用戶使用條款"
            }
        }
    }

}



struct LoginPage_Previews: PreviewProvider{
    static var previews: some View{
        LoginPage(changeToMain: .constant(true),gradeDataTitle:.constant([]),gradeDataScore:.constant([]))
    }
}

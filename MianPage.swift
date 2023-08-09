//
//  MianPage.swift
//  ShinherPRO
//
//  Created by 江祐鈞 on 2023/7/29.
//

import SwiftUI

struct MainPage: View {
    @Binding var gradeDataTitle:[String]
    @Binding var gradeDataScore:[String]
    @Binding var gradeDataTotal:String
//    @Binding var gradeData:[String:[String]]
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
                ZStack{
//                    Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
                    
                    Color.gray.opacity(0.09).edgesIgnoringSafeArea(.all)
                    ScrollView{
                        VStack(alignment: .leading){
                            Text("重點項目")
                                .font(.system(size: 26))
                                .fontWeight(.medium)
                        }.padding(.leading,geo.size.width*(-0.45))
//                        gradeDataTitle, id: \.self
                        ForEach(0..<1, id:\.self) { num in
                            NavigationLink {
                                GradePage(gradeDataTitle: $gradeDataTitle, gradeDataScore: $gradeDataScore,gradeDataTotal: $gradeDataTotal)
                                    .navigationTitle("成績")
                                    .navigationBarTitleDisplayMode(.inline)
//                                    Text("hello")
                            } label: {
                                MainPageFunc(titleText: "最新成績",gradeScore: gradeDataScore[num],widthSize: Float(geo.size.width),heightSize: Float(geo.size.height),subTitleText:gradeDataTitle[num])
//                                Text("hello")
                            }
                        }
                    }.navigationBarTitle(Text("首頁"))
                }
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        TabView{
            MainPage(gradeDataTitle:.constant(["國語文", "英語文", "數學", "化學", "資訊科技", "英語閱讀", "電子學", "微處理機"]),gradeDataScore: .constant(["65", "38", "60", "22", "80", "39", "52", "50"]),gradeDataTotal: .constant("1253"))
                .tabItem{
                    Image(systemName: "square.text.square.fill")
                }
        }
    }
}

struct MainPageFunc:View{
    @Environment(\.colorScheme) var colorScheme
    
    var titleText:String
    var gradeScore:String
    var widthSize:Float
    var heightSize:Float
    var subTitleText:String
    
    var body: some View{
        ZStack(alignment: .top){
            Text("")
                .foregroundColor(Color.white)
                .frame(width: CGFloat(widthSize)-40,height: 110)
                .background(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white)
                .cornerRadius(CGFloat(18))
                .shadow(color: .gray.opacity(0.1), radius: 20, x: 0, y: 0)
            VStack(alignment: .leading){
                HStack{
                    Label(titleText,systemImage: "text.book.closed.fill")
                        .foregroundColor(.mint)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color.gray)
                }.padding(.top,15)
//                .border(Color.blue,width:4)
                if subTitleText == ""{
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black.opacity(0))
                }
                VStack(alignment: .leading){
                    HStack{
                        Text(gradeScore)
                            .font(.system(size: 36,design: .rounded))
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                        Text("分")
                            .font(.system(size: 20))
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                            .padding(.top,10)
                    }.padding(.top,-4)
                    if subTitleText != ""{
                        Text(subTitleText)
                            .foregroundColor(.secondary)
                            .font(.system(size: 18))
                            .padding(.leading,2)
                            .padding(.top,-28)
                            .background(Rectangle().fill(Color.blue.opacity(0)))
                    }
                }
//                .border(Color.red,width: 5)
            }.padding(.horizontal,40)
        }.padding(.vertical,0)
        .frame(height: 120)
//        .border(Color.yellow,width:4)
        
    }
}

//struct MainPageFunc_Previews: PreviewProvider {
//    static var previews: some View {
//        MainPageFunc(titleText: "",widthSize: 500,heightSize: 1000)
//    }
//}

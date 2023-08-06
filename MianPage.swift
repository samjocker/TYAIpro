//
//  MianPage.swift
//  ShinherPRO
//
//  Created by 江祐鈞 on 2023/7/29.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
                ZStack{
                    Color.gray.opacity(0.09).edgesIgnoringSafeArea(.all)
                    ScrollView{
                        VStack(alignment: .leading){
                            Text("重點項目")
                                .font(.system(size: 26))
                                .fontWeight(.medium)
                        }.padding(.leading,geo.size.width*(-0.45))
//                        ForEach(sharedData.subjects, id: \.self) { subject in
//                            NavigationLink {
//                                Text("hello")
//                            } label: {
//                                MainPageFunc(titleText: "分數",widthSize: Float(geo.size.width),heightSize: Float(geo.size.height),subTitleText:subject)
//                            }
//                        }
                        ForEach(1..<8) { i in
                            if i == 2 || i == 4 {
                                NavigationLink {
                                    Text("hello")
                                } label: {
                                    MainPageFunc(titleText: "分數",widthSize: Float(geo.size.width),heightSize: Float(geo.size.height),subTitleText:"國文")
                                }
                            }else{
                                NavigationLink {
                                    Text("hello")
                                } label: {
                                    MainPageFunc(titleText: "分數",widthSize: Float(geo.size.width),heightSize: Float(geo.size.height),subTitleText:"")
                                }
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
            MainPage()
                .tabItem{
                    Image(systemName: "filemenu.and.selection")
                }
        }
    }
}

struct MainPageFunc:View{
    @Environment(\.colorScheme) var colorScheme
    
    var titleText:String
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
            HStack{
                Label("國語文",systemImage: "text.book.closed.fill")
                    .foregroundColor(Color(red: 0.0, green: 0.803921568627451, blue: 0.803921568627451))
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color.gray)
            }
            .padding(.horizontal,40)
            .padding(.top,15)
            VStack(alignment: .leading){
                HStack{
                    Text("54")
                        .font(.system(size: 36,design: .rounded))
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                    Text("分")
                        .font(.system(size: 20))
                        .foregroundColor(.secondary)
                        .fontWeight(.medium)
                        .padding(.top,10)
                }
//                .padding(.trailing,(CGFloat(widthSize)-40)*(0.66)).padding(.bottom,subTitleText != "" ? -12:0)
                if subTitleText != ""{
                    Text(subTitleText)
                        .foregroundColor(.secondary)
                        .font(.system(size: 18))
                        .frame(width: CGFloat(widthSize)*(0.6),height: 24,alignment: .leading)
                        .padding(.leading,2)
                        .background(Rectangle().fill(Color.blue.opacity(0)))
//                        .padding(.bottom,-4)
                }
            }.border(Color.red,width: 5)
//            .padding(.bottom,-42)
        }
//        .padding(.bottom,-8)
    }
}

//struct MainPageFunc_Previews: PreviewProvider {
//    static var previews: some View {
//        MainPageFunc(titleText: "",widthSize: 500,heightSize: 1000)
//    }
//}

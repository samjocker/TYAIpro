//
//  GradePage.swift
//  ShinherPRO
//
//  Created by 江祐鈞 on 2023/8/7.
//

import SwiftUI
import Charts

struct GradePage: View {
    @Binding var gradeDataTitle:[String]
    @Binding var gradeDataScore:[String]
    @State var whitchTest:String = "第二次段考"
    var body: some View {
        VStack {
            Picker("",selection: $whitchTest){
                Text("第一次段考")
                    .tag("第一次段考")
                Text("第二次段考")
                    .tag("第二次段考")
                Text("期末考")
                    .tag("期末考")
            }.pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top,-40)
                .padding(.bottom,10)
            GradeChart()
            Spacer()
        }
    }
    
    @ViewBuilder
    func GradeChart()->some View{
        Chart{
            ForEach(0..<gradeDataScore.count, id:\.self){ num in
                BarMark(
                    x:.value("Subject",gradeDataTitle[num]),
                    y:.value("Score",Int(gradeDataScore[num]) ?? 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.mint)
                .annotation{
                    Text(verbatim: gradeDataScore[num])
                        .foregroundColor(.secondary)
                }
            }
        }.frame(width:340,height: 300)
    }
}

struct GradePage_Previews: PreviewProvider {
    static var previews: some View {
//        GradePage(gradeDataTitle: .constant(["國語文", "英語文", "數學", "化學", "資訊科技", "英語閱讀", "電子學", "微處理機"]),gradeDataScore: .constant(["65", "38", "60", "22", "80", "39", "52", "50"]))
        
        NavigationView{
            NavigationLink {
                GradePage(gradeDataTitle: .constant(["國語文", "英語文", "數學", "化學", "資訊科技", "英語閱讀", "電子學", "微處理機"]), gradeDataScore: .constant(["65", "38", "60", "22", "80", "39", "52", "50"]))
            } label: {
                MainPageFunc(titleText: "分數",gradeScore: "66",widthSize: 400,heightSize: 620,subTitleText:"數學")
            }.navigationBarTitle(Text("首頁"))
        }
    }
}

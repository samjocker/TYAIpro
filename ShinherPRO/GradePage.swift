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
    @Binding var gradeDataTotal:String
    @State var whitchTest = "第一次段考"
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack (alignment: .leading){
                    Picker("",selection: $whitchTest){
                        Text("第一次段考")
                            .tag("第一次段考")
                        Text("第二次段考")
                            .tag("第二次段考")
                        Text("期末考")
                            .tag("期末考")
                    }.pickerStyle(.segmented)
                        .padding(.horizontal)
                        .padding(.vertical)
                    //                .padding(.top,-40)
                    VStack(alignment: .leading,spacing: 2){
                        Text("總分")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                        HStack {
                            Text(gradeDataTotal)
                                .font(.system(.largeTitle,design: .rounded))
                                .foregroundColor(.primary)
                                .fontWeight(.bold)
                            Text("分")
                                .font(.system(.title3))
                                .foregroundColor(.secondary)
                                .fontWeight(.medium)
                                .padding(.top,10)
                        }
                        Text(whitchTest)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                        
                        GradeChart()
                    }
                    //                .border(.blue,width:1)
                    .padding(.horizontal)
                    
                    Spacer()
                }.background(.white)
            }
        }.background(Color.gray.opacity(0.09))
//            .edgesIgnoringSafeArea(.all)
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
        }
        .frame(width:360,height: 300)
    }
}

struct GradePage_Previews: PreviewProvider {
    static var previews: some View {
//        GradePage(gradeDataTitle: .constant(["國語文", "英語文", "數學", "化學", "資訊科技", "英語閱讀", "電子學", "微處理機"]),gradeDataScore: .constant(["65", "38", "60", "22", "80", "39", "52", "50"]))
        
        GradePage(gradeDataTitle: .constant(["國語文", "英語文", "數學", "化學", "資訊科技", "英語閱讀", "電子學", "微處理機"]), gradeDataScore: .constant(["65", "38", "60", "22", "80", "39", "52", "50"]),gradeDataTotal: .constant("1253"))
        
//        NavigationView{
//            NavigationLink {
//                GradePage(gradeDataTitle: .constant(["國語文", "英語文", "數學", "化學", "資訊科技", "英語閱讀", "電子學", "微處理機"]), gradeDataScore: .constant(["65", "38", "60", "22", "80", "39", "52", "50"]),gradeDataTotal: .constant("1253"))
//            } label: {
//                MainPageFunc(titleText: "分數",gradeScore: "66",widthSize: 400,heightSize: 620,subTitleText:"數學")
//            }.navigationBarTitle(Text("首頁"))
//        }
    }
}

//
//  TabBar.swift
//  ShinherPRO
//
//  Created by 江祐鈞 on 2023/8/4.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        ZStack{
            Rectangle()
                .frame(height: 60)
                .foregroundColor(.secondary.opacity(0.1))
            HStack(alignment: .center, spacing: 48){
                Image(systemName: "person.text.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .foregroundColor(.secondary)
                Image(systemName: "filemenu.and.selection")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .foregroundColor(.secondary)
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                    .foregroundColor(.secondary)
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                    .foregroundColor(.secondary)
            }
        }.background(.ultraThinMaterial)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

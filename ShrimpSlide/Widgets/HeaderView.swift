//
//  HeaderView.swift
//  ShrimpSlide
//
//  Created by jaeeun on 1/18/25.
//

import SwiftUI


struct HeaderView: View {
    var title: String
//    var onLeftButtonTap: () -> Void
//    var onRightButtonTap: () -> Void

    var body: some View {
        HStack {
            // 왼쪽 버튼
//            Button(action: onLeftButtonTap) {
//                Image(systemName: "chevron.left") // 아이콘
//                    .font(.title2)
//                    .foregroundColor(.blue)
//            }

            Spacer()

            // 제목
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer()

            // 오른쪽 버튼
//            Button(action: onRightButtonTap) {
//                Image(systemName: "gearshape") // 아이콘
//                    .font(.title2)
//                    .foregroundColor(.blue)
//            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
    }
}

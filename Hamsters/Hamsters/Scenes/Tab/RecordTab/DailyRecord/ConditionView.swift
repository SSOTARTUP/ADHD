//
//  ConditionView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/10/23.
//

import SwiftUI

struct ConditionView: View {
    @ObservedObject var dailyRecordViewModel: DailyRecordViewModel
    
    @StateObject var viewModel = ConditionViewModel()
    @State var scroll:ScrollViewProxy?
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                HStack {
                    Text("오늘의 컨디션")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                    Spacer()
                }
                ForEach(Array(viewModel.list.enumerated()),id: \.self.offset) { (offset,element) in
                    switch element.first?.sender {
                    case .computer:
                        ComputerChat(offset:offset, viewModel: viewModel)
                            .id(offset)
                    case .user:
                        UserChat(viewModel: viewModel,conditionModel: element.first)
                            .id(offset)
                    case .button:
                        NextButton(title: "다음", isActive: .constant(true)) {
                            dailyRecordViewModel.answer = viewModel.answer
                            dailyRecordViewModel.bottomButtonClicked()
                        }
                        .padding(.top,24)
                        .padding(.bottom,40)
                    case .none:
                        let _ = print("nil")
                    }
                }
            }.onAppear {
                scroll = value
            }
        }.onChange(of: viewModel.stack) { _ in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                withAnimation {
                    scroll?.scrollTo(viewModel.list.count - 1, anchor: .bottom)
                }
            }
        }

    }
}


#Preview {
    ConditionView(dailyRecordViewModel: DailyRecordViewModel())
}

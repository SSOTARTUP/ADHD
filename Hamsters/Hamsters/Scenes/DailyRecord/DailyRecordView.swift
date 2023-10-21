//
//  DailyRecordView.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 10/18/23.
//

import SwiftUI

struct DailyRecordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pageNumber = 1
    @State private var conditionValues: [Double] = Array(repeating: 0.0, count: Condition.allCases.count)
    @State private var moodValues: [Double] = Array(repeating: 0.0, count: Mood.allCases.count)
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch pageNumber {
                case 1: // ADHD 컨디션 기록
                    VStack(alignment: .leading, spacing: 12) {
                        DailyRecordProgressBar(pageNumber: $pageNumber)
                        
                        ConditionCheckView(pageNumber: $pageNumber, userValues: $conditionValues)
                    }
                case 2: // 감정 기록
                    VStack(alignment: .leading, spacing: 12) {
                        DailyRecordProgressBar(pageNumber: $pageNumber)
                        
                        MoodCheckView(pageNumber: $pageNumber, userValues: $moodValues)
                    }
                    
                default:
                    EmptyView()
                }
            }
            .navigationTitle("오늘의 상태 기록하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if pageNumber > 1 {
                        backButton
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    closeButton
                }
            }
        }
    }
    
    private var backButton: some View {
        Button {
            pageNumber -= 1
        } label: {
            Image(systemName: "chevron.backward")
                .fontWeight(.semibold)
                .foregroundStyle(.thoNavy)
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.thoNavy)
        }
    }
}

#Preview {
    DailyRecordView()
}

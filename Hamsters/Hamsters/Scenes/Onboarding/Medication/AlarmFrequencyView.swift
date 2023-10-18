//
//  AlarmFrequencyView.swift
//  Hamsters
//
//  Created by YU WONGEUN on 10/17/23.
//

import SwiftUI

struct AlarmFrequencyView: View {
    @Environment(\.dismiss) private var dismiss
        
    @Binding var selectedOption: Option?
    @Binding var selectedDays: [Day]
    @Binding var startDay: Date
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(zip(0..<Option.allCases.count, Option.allCases)), id: \.0) { index, option in
                    
                    if index > 0 {
                        Divider()
                    }
                    
                    HStack {
                        Text("\(option.rawValue)")
                            .font(.body)
                        
                        Spacer()
                        
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                                .font(.headline)
                                .foregroundStyle(.blue)
                            
                        }
                    }
                    .padding(.vertical, 14)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if index == 0 {
                            selectedOption = option
                        } else {
                            selectedOption = option
                            selectedDays.removeAll()
                        }
                    }
                }
                .padding(.horizontal, 16)
                .background(.thoTextField)
            }
            .cornerRadius(10)
            .padding(.top, 24)
            .padding(.bottom, 44)
            
            if selectedOption == Option.specificDay || !selectedDays.isEmpty {
                Text("요일 선택")
                    .font(.headline)
                    .foregroundStyle(.thoNavy)
                    .padding(.leading, 8)
                    .padding(.bottom, 6)
                
                HStack(spacing: 0) {
                    ForEach(Day.allCases, id: \.self) { day in
                        Text(String(day.rawValue.first!))
                            .font(.title3)
                            .foregroundStyle(selectedDays.contains(day) ? Color.white : Color.black)
                            .padding(14)
                            .background(
                                Circle()
                                    .fill(selectedDays.contains(day) ? Color.thoNavy : Color.clear)
                            )
                        
                            .onTapGesture {
                                if selectedDays.contains(day) {
                                    selectedDays.removeAll(where: {$0 == day})
                                } else {
                                    selectedDays.append(day)
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .background(Color.thoTextField)
                .cornerRadius(10)
                .padding(.bottom, 44)
            }
            
            DatePicker("시작일", selection: $startDay, displayedComponents: .date)
                .font(.body)
                .padding(.horizontal, 8)
                .padding(.vertical, 11)
                .background(Color.thoTextField)
                .cornerRadius(10)
            
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationTitle("빈도")
        .navigationBarBackButtonHidden()
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("뒤로")
                })
            }
        }
        
    }
    
}

#Preview {
    AlarmFrequencyView(selectedOption: .constant(.specificDay), selectedDays:.constant([.monday, .wednesday]), startDay: .constant(Date()))
}

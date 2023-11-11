//
//  ActivityView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/11/23.
//

import SwiftUI

struct ActivityView: View {
    
    @State var showingSheet = false
    @State var isActive = true
    @State var list:Activities = []
    
    var body: some View {
        VStack(spacing:0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("운동을 기록해주세요")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading,16)
                
                Button(action: {
                    showingSheet.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("운동 추가하기")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.thoNavy)
                    .cornerRadius(15)
                })
                .padding(.horizontal,24)
                .padding(.top,20+16)
                .sheet(isPresented: $showingSheet) {
                    ActivityModalView(list:$list)
                }
            }
                .padding(.bottom,24)
            
            List{
                Section {
                    ForEach(list.filter{ $0.from == .user}) { activity in
                        HStack {
                            Text(activity.name)
                                .font(.body)
                            Spacer()
                            Text(activity.dsc)
                                .font(.body)
                                .foregroundStyle(.thoNavy)
                        }
                        .frame(height:44)
                        .padding(.horizontal,16)
                        .listRowBackground(Color.thoTextField)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }.onDelete { indexSet in
                        list.remove(atOffsets: indexSet)
                    }
                    
                    
                } header: {
                    HStack {
                        Text("내가 추가한 운동")
                            .font(.headline)
                            .foregroundStyle(.sectionTitle)
                            .bold()
                        Spacer()
                    }
                }
                
                Section {
                    HStack {
                        Text("헬스킷 연동 예정.").padding(0)
                    }
                        .listRowBackground(Color.thoTextField)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                } header: {
                    HStack {
                        Text("연동된 운동 데이터")
                            .font(.headline)
                            .foregroundStyle(.sectionTitle)
                            .bold()
                        Spacer()
                    }
                }

            }
            .listRowBackground(Color.blue)
            .background(.white)
            .scrollContentBackground(.hidden)
            
            Spacer()
            
            NextButton(title: "다음", isActive: $isActive) {
                
            }
            .padding(.horizontal,24)
            .padding(.bottom,30)

            
        }
    }
}

extension ActivityView {
    typealias Activities = [Activity]
    
    struct Activity:Identifiable {
        var id = UUID()
        let from:From
        var name:String
        var time:Int
        
        enum From {
            case user
            case healthKit
        }
        
        var dsc:String{
            if time%60 == 0 {
                return "\(self.time/60)시간"
            } else if time < 60 {
                return "\(self.time%60)분"
            } else {
                return "\(self.time/60)시간 \(self.time%60)분"
            }
        }
        
        init?(from: From, name: String, time: Int) {
            guard name.count > 0 && name.count <= 15 else {
                return nil
            }
            guard time > 0 else {
                return nil
            }
            self.from = from
            self.name = name
            self.time = time
        }
    }
    
}

#Preview {
    ActivityView()
}

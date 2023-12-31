//
//  WelcomeView.swift
//  Hamsters
//
//  Created by jaesik pyeon on 11/8/23.
//

import Foundation
import SwiftUI

struct Info:Identifiable{
    let id = UUID()
    let title:String
    let sub:String
    let imageName: String
}

struct WelcomeView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var selectedIndex = 0
    @State var isPresentedBottomSheet: Bool = false

    let infos = [
        Info(title: "새로운 시작을 위한\n첫 걸음", sub: "클록과 함께 쉽고 간편하게\n나의 증상을 기록하고 관리해요!", imageName: "Welcome1"),
        Info(title: "나의 증상을\n한눈에 알기 쉽게", sub: "내가 기록한 매일의 기록을\n한 눈에 보기 편하게 알려줘요!", imageName: "Welcome2"),
        Info(title: "일상을 변화시킬\n나만의 단서", sub: "내가 기록한 매일의 기록이 쌓여\n나의 변화를 보기 쉽게 통계로 보여줘요!", imageName: "Welcome3")
    ]
 
    var body: some View {
        VStack {
            Spacer()
            TabView(selection: $selectedIndex) {
                ForEach(infos.indices,id:\.self) { index in
                    VStack(spacing: 16) {
                        Image(infos[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 180)
                            .padding(.horizontal, 104)
                        
                        Text(infos[index].title)
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)
                            
                        Text(infos[index].sub)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear{
                setUpDot()
            }
            .frame(height: 400)

            Spacer()
            
            OnboardingNextButton(isActive: .constant(true), title: viewModel.onboardingPage.nextButtonTitle) {
                isPresentedBottomSheet.toggle()
            }
        }
        .sheet(isPresented: $isPresentedBottomSheet) {
            TermsView(isPresentedBottomSheet: $isPresentedBottomSheet)
                .presentationDetents([.height(475)])
        }
    }
}

struct TermsView:View{
    @EnvironmentObject var viewModel: OnboardingViewModel
    @Binding var isPresentedBottomSheet:Bool
    
    var body: some View{
        NavigationStack {
            VStack(spacing: 0) {
                Image("HamLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height:100)
                
                Text("원활한 서비스 이용을 위해\n먼저 이용약관 제공에 동의해 주세요.")
                    .multilineTextAlignment(.center)
                    .fixedSize()
                    .font(.headline)
                    .bold()
                    .padding(.top,16)
                
                HStack{
                    Text("개인 정보 처리 방침(필수)")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://cooperative-coast-cf5.notion.site/f8a0eee2711e4613a70400bd7ae40132?pvs=4")!) {
                        Image(systemName: "chevron.forward")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                    }
                }
                .padding(.horizontal,24)
                .padding(.top,40)
                
                HStack{
                    Text("이용 약관 동의(필수)")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://cooperative-coast-cf5.notion.site/8dec0150593b404a9071bacbc066c3e0?pvs=4")!) {
                        Image(systemName: "chevron.forward")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                    }
                }
                .padding(.horizontal,24)
                .padding(.top,12)
                .padding(.bottom, 50)
                
                OnboardingNextButton(isActive: .constant(true), title: "전체 동의 및 다음") {
                    viewModel.onboardingPage = .profile
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        isPresentedBottomSheet = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(Color.secondary)

                    }
                }
            }
        }
    }
}

extension WelcomeView{
    func setUpDot(){
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.3)
    }
}

#Preview{
    WelcomeView()
}

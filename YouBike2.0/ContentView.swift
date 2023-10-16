//
//  ContentView.swift
//  YouBike2.0
//
//  Created by 褚宣德 on 2023/10/9.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowedSarea = false
    var body: some View {
        NavigationStack {
            Spacer()
        VStack {
            Spacer()
            Spacer()
            HStack {
                Image("UbikeSmile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 50)
                    .padding([.leading, .bottom])
                
                Spacer()
                Button { } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.ubikeGreen)
                        .padding([.bottom, .trailing])
                }
                
            }
            .background(.white)
                VStack {
                    Spacer()
                    HStack {
                        Button { } label: {
                            Text("使用說明")
                                .buttonStyleModifier()
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    Spacer()
                    HStack {
                        Button { } label: {
                            Text("收費方式")
                                .buttonStyleModifier()
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    Spacer()
                    HStack {
                        Button {
                            isShowedSarea = true
                        } label: {
                            Text("站點資訊")
                                .buttonStyleModifier()
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    Spacer()
                    HStack {
                        Button { } label: {
                            Text("最新消息")
                                .buttonStyleModifier()
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    Spacer()
                    HStack {
                        Button { } label: {
                            Text("活動專區")
                                .buttonStyleModifier()
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    Group {
                        ForEach(0..<5) { _ in
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        Button { } label: {
                            Text("登入")
                                .foregroundStyle(.ubikeGreen)
                                .background(
                                    Capsule()
                                        .frame(width: 100, height: 50)
                                        .foregroundStyle(.white)
                                )
                        }
                        Group {
                            ForEach(0..<7) { _ in
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                    
                    
                }
                .padding(.leading)
                
                .background(.ubikeGreen)
                Spacer()
            }
            .ignoresSafeArea()
            .sheet(isPresented: $isShowedSarea) {
                YouBileSareaView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}

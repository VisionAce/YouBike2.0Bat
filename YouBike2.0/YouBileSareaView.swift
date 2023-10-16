//
//  YouBileSareaView.swift
//  YouBike2.0
//
//  Created by 褚宣德 on 2023/10/14.
//

import SwiftUI

struct YouBileSareaView: View {
    @Environment(\.dismiss) var dismiss
    @State private var youbikes = [WelcomeElement]()
    @State private var searchText = ""
    @State private var rowCount = 0
    @State private var pickerSarea = "松山區"
    @State private var sareaSet = Set<String>()
    @State private var sareaArray = [String]()
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return sareaArray
        } else {
            return sareaArray.filter { $0.contains(searchText) }
        }
    }
    
    let layout = [
        GridItem(.fixed(85)),
        GridItem(.fixed(85)),
        GridItem(.fixed(170))
    ]
    
    var body: some View {
        HStack {
            Image("UbikeSmile")
                .resizable()
                .padding([.top, .leading])
                .scaledToFill()
                .frame(width: 100, height: 50)
                
               
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "list.bullet")
                    .resizable()
                    .frame(width: 40, height: 25)
                    .foregroundStyle(.ubikeGreen)
                    .padding([.top, .trailing])
            }
        }
        .background(.white)
        DividerView()
        HStack {
            Spacer()
            Text("站點資訊")
                .font(.title.bold())
                .foregroundStyle(.ubikeGreen)
            ForEach(0..<10) { _ in
                Spacer()
            }
        }
        NavigationStack {
            Text("搜尋... \(searchText)")
            VStack {
                ScrollView {
                    LazyVGrid(columns: layout) {
                        Group {
                            Text("縣市")
                                .background(
                                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 25))
                                        .fill(.ubikeGreen)
                                        .frame(width: 120, height: 50)
                                )
                            Text("區域")
                                .background(
                                    Rectangle()
                                        .fill(.ubikeGreen)
                                        .frame(width: 150, height: 50)
                                )
                            Text("站點名稱")
                                .background(
                                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 25, topTrailing: 25))
                                        .fill(.ubikeGreen)
                                        .frame(width: 200, height: 50)
                                )
                                
                        }
                        
                        .foregroundStyle(.white)
                        .padding()
                        
                        if searchText.isEmpty {
                            
                            ForEach(youbikes, id: \.id) { item in
                                var processedString: String {
                                    let prefixToRemove = "YouBike2.0_"
                                    return item.sna.replacingOccurrences(of: prefixToRemove, with: "")
                                }
                                
                                Group {
                                    Text("台北市")
                                    Text("\(item.sarea)")
                                    Text(processedString)
                                }
                                .foregroundStyle(
                                    Int(item.sno)! % 2 == 0 ? .black : .brown
                                )

                            }
                            .padding([.horizontal, .bottom])
                     
                        } else {
                            
                                let sareaData = youbikes.filter { $0.sarea.contains(String(searchText)) }
                                ForEach(sareaData, id: \.id) { item in
                                    var processedString: String {
                                        let prefixToRemove = "YouBike2.0_"
                                        return item.sna.replacingOccurrences(of: prefixToRemove, with: "")
                                    }
                                    Group {
                                        Text("台北市")
                                        Text("\(item.sarea)")
                                        Text(processedString)
                                    }
                                    .foregroundStyle(
                                        Int(item.sno)! % 2 == 0 ? .black : .brown
                                    )
                                }
                                .padding([.horizontal, .bottom])
                            
                        }
                    } // LazyVGrid
                    .padding([.horizontal])
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .strokeBorder(.gray, lineWidth: 2)
                            .fill(.gray.opacity(0.2))
                    )
                    
                } // ScrollView
                .task {
                    await loadData()
                }
                
            }
            .padding(.horizontal)
            .searchable(text: $searchText) {
                ForEach(searchResults, id: \.self) { result in
                    Text("\(result)").searchCompletion(result)
                        .foregroundStyle(.primary)
                }
            }
            .dismissKeyboard()
            // 隱藏搜尋建議
            /*.searchable(text: $searchText, suggestions: {
                ForEach(searchResults, id: \.self) { result in
                    Text("\(result)").searchCompletion(result)
                        .foregroundStyle(.primary)
                }
                .searchSuggestions(.hidden, for: .content)
            }) */
        }
      
        
    }
    
    func loadData() async {
        guard let url = URL(string: Constants.youBikeAPiKey) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode( [WelcomeElement].self, from: data) {
                youbikes = decodedResponse
                
                for i in decodedResponse {
                    sareaSet.insert(i.sarea)
                }
                sareaArray = Array(sareaSet.sorted())
                print(sareaArray)
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview("YouBileSareaView") {
    YouBileSareaView()
}

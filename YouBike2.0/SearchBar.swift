//
//  SearchBar.swift
//  YouBike2.0
//
//  Created by 褚宣德 on 2023/10/9.
//

import SwiftUI

struct ContentView2: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }

    
    let names = ["Holly", "Josh", "Rhonda", "Ted"]

    var body: some View {
        NavigationStack {
            Text("Searching for \(searchText)")
            List {
                        ForEach(searchResults, id: \.self) { name in
                            NavigationLink {
                                Text(name)
                            } label: {
                                Text(name)
                            }
                        }
                    }
                .navigationTitle("Contacts")
        }
        .searchable(text: $searchText) {
            ForEach(searchResults, id: \.self) { result in
                           Text("Are you looking for \(result)?").searchCompletion(result)
                       }
        }
    }
    
}


struct Message: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
}

enum SearchScope: String, CaseIterable {
    case inbox, favorites
}




struct ContentView3: View {
    @State private var messages = [Message]()

    @State private var searchText = ""
    @State private var searchScope = SearchScope.inbox

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredMessages) { message in
                    VStack(alignment: .leading) {
                        Text(message.user)
                            .font(.headline)

                        Text(message.text)
                    }
                }
            }
            .navigationTitle("Messages")
        }
        .searchable(text: $searchText)
        .searchScopes($searchScope) {
            ForEach(SearchScope.allCases, id: \.self) { scope in
                Text(scope.rawValue.capitalized)
            }
        }
        .onAppear(perform: runSearch)
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchScope) { oldState, newState in
            runSearch()
        }
//        .onChange(of: searchScope) { _ in runSearch() }
    }

    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func runSearch() {
        Task {
            guard let url = URL(string: "https://hws.dev/\(searchScope.rawValue).json") else { return }

            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        }
    }
}

struct ContentView4: View {
    //    @State private var messages = [Message]()
    @State private var youBikeData: [WelcomeElement]?
    
    @State private var searchText = ""
    @State private var searchScope = ""
    
    var body: some View {
        NavigationStack {
            List {
                //                ForEach(filteredMessages) { message in
                //                    VStack(alignment: .leading) {
                //                        Text(message.user)
                //                            .font(.headline)
                //
                //                        Text(message.text)
                //                    }
                //                }
                Text("\(youBikeData?.count ?? 0)")
            
                    ForEach(0..<1318) {
        
                        Text("\((youBikeData?[$0].sna) ?? "")")
                    }
                
            }
            .navigationTitle("Messages")
        }
                .searchable(text: $searchText)
                .searchScopes($searchScope) {
                    ForEach(SearchScope.allCases, id: \.self) { scope in
                        Text(scope.rawValue.capitalized)
                    }
                }
        .onAppear(perform: runSearch)
        //        .onSubmit(of: .search, runSearch)
        //        .onChange(of: searchScope) { oldState, newState in
        //            runSearch()
        //        }
        
    }
    
        var filteredMessages: [WelcomeElement]? {
            if searchText.isEmpty {
                return youBikeData
            } else {
                return []/*youBikeData.filter { $0.sarea(searchText) }*/
            }
        }
    
    func runSearch() {
        Task {
            guard let url = URL(string: Constants.youBikeAPiKey) else { return }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            youBikeData = try JSONDecoder().decode([WelcomeElement].self, from: data)
        }
    }
}

#Preview("ContentView4") {
    ContentView4()
}

#Preview("ContentView3") {
    ContentView3()
}


#Preview("ContentView2") {
    ContentView2()
}


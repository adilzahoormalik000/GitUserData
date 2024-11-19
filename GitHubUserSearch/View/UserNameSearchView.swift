//
//  UserNameSearchView.swift
//  GitHubUserSearch
//
//  Created by ADIL ZAHOOR MALIK on 19/11/2024.
//

import SwiftUI

struct UserNameSearchView: View {
    @StateObject private var vm = GitHubSearchViewModel()
    var body: some View {
        VStack(spacing: 25) {
            CustomSearchTF(placeholder: "Enter User Name", keyboardType: .alphabet, text: $vm.searchQuery)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary))
                .padding(.horizontal)
                .padding(.top)
                .shadow(radius: 5)
            
            AppButton(title: "Search") {
                Task{
                    await     vm.searchUsersAPI()
                }
            }
            
            .padding()
            if vm.isLoading {
                ProgressView()
                if vm.showError{
                    Text(vm.errorMessage ?? "Something went wrong")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            
            ScrollView{
                
                ForEach(vm.searchResults, id: \.self) { user in
                    NavigationLink{
                        
                        UserDetailsView(username: user.login)
                        
                    }label: {
                        
                        HStack{
                            AsyncImage(url: URL(string: user.avatarURL)){ image in
                                image
                                
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                
                                
                            } placeholder: {
                                ProgressView()
                            }
                            Text(user.login)
                        }
                    }
                    
                }
            }
            
            
            if !vm.searchResults.isEmpty {
                VStack(alignment: .leading){
                    Text("Search History")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView {
                        ForEach(vm.searchHistory, id: \.self){ history in
                            Button {
                                vm.searchQuery = history
                                Task{
                                    await vm.searchUsersAPI()
                                }
                            } label: {
                                Text(history)
                                    .foregroundColor(.accent)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 1))
                                    
                            }

                        }
                    }
                    .frame(height: 200)
                    .padding(.top)
                }
                .padding(.top, 10)
            }
            
      
            
           
            
            
        }
        
    }
}

#Preview {
    UserNameSearchView()
        .preferredColorScheme(.dark)
}

//
//  UserDetailsView.swift
//  GitHubUserSearch
//
//  Created by ADIL ZAHOOR MALIK on 19/11/2024.
//

import SwiftUI

struct UserDetailsView: View {
    @State var username : String
    @StateObject var vm = GitHubSearchViewModel()
    var body: some View {
        VStack{
            if vm.isLoading {
                ProgressView()
            } else {
                if let user = vm.searchedUserDetail {
                    VStack{
                        AsyncImage(url: URL(string: user.avatarURL)){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.circle)
                                .frame(width: 150, height: 150)
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        }
                        Text(user.login)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                            .foregroundColor(.primary)
                        Text("GitHub User")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        VStack(alignment:.leading,spacing: 12){
                            Text("Repositories: \(user.reposURL)")
                                .foregroundColor(.accent)
                            Text("Followers: \(user.followersURL)")
                                .foregroundColor(.accent)
                            Text("Following: \(user.followingURL)")
                                .foregroundColor(.accent)
                            Text("")
                        }
                        .padding(.horizontal)
                        Spacer()
                        
                       
                    }
                }
            }
        }.onAppear(){
            Task{
                await vm.userDetailsAPI(username: username)
            }
        }
        .navigationTitle(username)
    }
}

#Preview {
    UserDetailsView(username: "asdf")
}

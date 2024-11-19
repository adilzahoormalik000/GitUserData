//
//  GitHubSearchViewModel.swift
//  GitHubUserSearch
//
//  Created by ADIL ZAHOOR MALIK on 19/11/2024.
//

import Foundation
import Combine
@MainActor
class GitHubSearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResults: [User] = []
    @Published var searchedUserDetail : UserDetailModel?
    @Published var searchHistory: [String] = UserDefaults.standard.stringArray(forKey: "searchHistory") ?? []
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    
    
}

extension GitHubSearchViewModel: NetworkManagerService {
    
    func searchUsersAPI() async {
        let trimmedQuery  =  searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedQuery.isEmpty {
            showError(message: "Please enter a username to search")
            return
        }
        if !searchHistory.contains(trimmedQuery){
            DispatchQueue.main.async  {
                self.searchHistory.insert(trimmedQuery, at: 0)
                UserDefaults.standard.set(self.searchHistory, forKey: "searchHistory")
            }
        }
        DispatchQueue.main.async {
            self.isLoading = true
        }
       
        let endpoint =  GitHubUserSearchEndpoint(query: trimmedQuery)
        let request = await sendRequest(endpoint: endpoint, responseModel: UsersData.self)
        
        Task {
//            let result : Result <GenericResponseModel<UsersData>, RequestError> = await sendRequest(endpoint: endpoint, responseModel: UsersData.self)
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
//            let request = await sendRequest(endpoint: endPoint, responseModel: TransformedTextModel.self)
            
            switch request {
            case .success(let response):
                DispatchQueue.main.async{
                    self.searchResults = response.users

                        
                        
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.searchResults = []
                    self.showError(message: error.customMessage)
                }
            }
            
        }
    }
  
    func userDetailsAPI(username: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
       
        let endpoint = GitHubUserDetailEndpoint(username: username)

        let request = await sendRequest(endpoint: endpoint, responseModel: UserDetailModel.self)
            isLoading = false
        switch request {
            case .success(let response):
                DispatchQueue.main.async {
                    
                    
                    self.searchedUserDetail = response
                        self.errorMessage = nil
                        self.showError = false
            
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(message: error.localizedDescription)
                }
            }
        
    }
        
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showError = true
        }
    }
}

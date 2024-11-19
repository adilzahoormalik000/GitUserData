//
//  AppButton.swift
//  GitHubUserSearch
//
//  Created by ADIL ZAHOOR MALIK on 19/11/2024.
//
import SwiftUI

struct AppButton: View {
    private var title: String
    private var action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    var body: some View {
        Button(action: {
            action()
        }){
            ZStack{
                RoundedRectangle(cornerRadius: 80)
                    .foregroundStyle(.accent)
                    .frame(height: 72)
                Text(title)
                    .font(.system(size: 24).bold())
                    .foregroundColor(.black)
            }
        }
         
        

    }
}

#Preview {
    AppButton(title: "Search", action: {
        print("Button Tapped")
    })
}

//
//  CustomSearchTF.swift
//  GitHubUserSearch
//
//  Created by ADIL ZAHOOR MALIK on 19/11/2024.
//


import SwiftUI

struct CustomSearchTF: View {
    private var placeholder: String
    private var keyboardType: UIKeyboardType
    @Binding private var text: String
    
    @FocusState private var isFocused: Bool
    init(placeholder: String, keyboardType: UIKeyboardType, text:Binding< String>) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._text = text
        
        
    }
    var body: some View {
      
        loadView()
    }
}

extension CustomSearchTF {
    func loadView() -> some View {
        VStack{
           
            textfield()
        }
    }
    func textfield() -> some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .frame(height: 72)
            
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                    .zIndex(1)
            }

                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .focused($isFocused)
                    .font(.system(size: 12))
                    .foregroundColor(.accent)
                    .padding(.leading, 16)
                    .frame(height: 72)
                    .zIndex(2)
          
            
        }
        .overlay (
            RoundedRectangle(cornerRadius: 24)
                .stroke(isFocused ? .accent : ( Color.white), lineWidth: 1)
                
        )
    
    }
}

#Preview {
    CustomSearchTF(placeholder: "Enter Username Or Email", keyboardType: .emailAddress, text: .constant(""))
        .preferredColorScheme(.dark)
}




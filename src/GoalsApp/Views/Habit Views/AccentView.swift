//
//  AccentView.swift
//  Goals
//
//  Created by Garrison Creek on 2/4/24.
//

import SwiftUI

struct AccentView: View {
    var accent: Accent
    @Binding var selection: Accent
    
    var body: some View {
        
        VStack {
            Button(action: {
                selection = accent
                print("accent selected: \(accent.name)")
            }) {
                if accent == selection {
                    Circle()
                        .stroke(.black, lineWidth: 0.2)
                        .background(Circle().fill(.white).frame(width:6,height:6))
                        .background(Circle().fill(accent.mainColor))
                        .frame(width: 20, height: 20)
                    
                } else {
                    Circle()
                        .stroke(.black, lineWidth: 0.2)
                        .background(Circle().fill(accent.mainColor))
                        .frame(width: 20, height: 20)
                }
            }
        }
        
    }
}

struct AccentView_Previews: PreviewProvider {
    static var previews: some View {
        AccentView(accent: .blue, selection: .constant(.blue))
    }
}

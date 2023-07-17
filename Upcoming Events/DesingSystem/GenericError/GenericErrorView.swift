//
//  GenericErrorView.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import SwiftUI

struct GenericErrorView: View {
    let title: String
    let subtitle: String
    let acceptAction: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text(subtitle)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)

            Button(action: acceptAction) {
                VStack {
                    Text("Accept")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .frame(width: 300, height: 300)
        .background(.cyan)
        .cornerRadius(25)
    }
}

struct GenericErrorView_Previews: PreviewProvider {
    static var previews: some View {
        GenericErrorView(title: "Some Title",
                         subtitle: "Some Subtitle",
                         acceptAction: {})
    }
}

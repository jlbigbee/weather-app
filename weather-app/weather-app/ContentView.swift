//
//  ContentView.swift
//  weather-app
//
//  Created by Jonathan Bigbee on 3/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var input: String = ""
    var body: some View {
        VStack {
          TextField("Enter City", text: $input)
                .font(.title)
            
            Divider()
            
            Text(input)
                .font(.body)
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

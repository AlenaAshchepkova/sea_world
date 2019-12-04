//
//  ContentView.swift
//  ashchepkova-sea-world
//
//  Created by Alena Ashchepkova on 19.11.2019.
//  Copyright © 2019 Alena Ashchepkova. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var seaWorldVM = SeaWorldViewModel()
    let worldColor: Color = Color.init(red: 155/255, green: 212/255, blue: 245/255)
    
    var body: some View {
        
        ZStack {
            worldColor
            .edgesIgnoringSafeArea(.all)

        VStack {
            Text("Hello, sea World!")
                .padding().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .topLeading).font(.largeTitle).scaledToFit()
            HStack (alignment: .center) {
                Text("Step")
                Text("\(seaWorldVM.totalClicked)")
            }
            Spacer()
            
            VStack(spacing: 0) {
                 ForEach(seaWorldVM.rows) { row in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(row.cells) { cell in
                            Image(cell.imageName)
                                .resizable()
                                .scaledToFit()
                                .background(self.worldColor)
                                .border(Color.gray, width: 1)
                                .gesture(TapGesture().onEnded { _ in
                                    self.seaWorldVM.tableWasTapped()
                            })
                        }
                    }.foregroundColor(self.worldColor)
                }
            }.padding(EdgeInsets.init(top: 0, leading: 5, bottom: 0, trailing: 5))
                .foregroundColor(self.worldColor)
            
            Spacer()
            Button(action: {
                self.seaWorldVM.buttonRefreshWasTapped()
            }) {
                Text("Refresh").font(.largeTitle)
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        ContentView()
    }
}

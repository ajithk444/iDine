//
//  ContentView.swift
//  iDine
//
//  Created by Ajith Kumar on 31/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
        
        
        NavigationView {
            List {
                ForEach(menu){ section in
                   Section(header: Text(section.name))
                   {
                        ForEach(section.items){ item in
                            
                            NavigationLink(destination:ItemDetail(item: item)){
                                    ItemRow(item: item)
                                }
                            }
                        }
                   }
            }
            .navigationTitle("Menu")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

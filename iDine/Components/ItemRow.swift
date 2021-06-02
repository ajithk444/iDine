//
//  ItemRow.swift
//  iDine
//
//  Created by Ajith Kumar on 31/05/21.
//

import SwiftUI

struct ItemRow: View {
    
    let colors: [String:Color] = ["D":.purple,"V":.green, "G":.black,"N":.red,"S":.blue]
    
    let item:MenuItem
    
    var body: some View {
        HStack {
            Image(item.thumbnailImage).clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))

            VStack(alignment: .leading) {
                Text(item.name).font(.headline)
                Text("$\(item.price)")
            }
            Spacer()
            ForEach(item.restrictions,id: \.self){ restriction in
                Text(restriction).font(.caption).fontWeight(.black).padding(5)
                    .background(colors[restriction, default:.black])
                    .clipShape(Circle()).foregroundColor(.white)
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
        
    }
}

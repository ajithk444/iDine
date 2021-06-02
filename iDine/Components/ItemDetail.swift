//
//  ItemDetail.swift
//  iDine
//
//  Created by Ajith Kumar on 31/05/21.
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order : Order
    
    let item:MenuItem
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing){
                Image(item.mainImage).resizable().scaledToFit()
                Text("Credit : \(item.photoCredit)")
                    .padding(4).background(Color.black).foregroundColor(.white).font(.caption).offset(x:-5,y:-5)
            }
            Text(item.description).padding()
            
            HStack {
                Button("-"){
                    order.remove(item: item)
                }.padding().background(Color.red).clipShape(Circle()).foregroundColor(.white)
                
                Button("+"){
                    order.add(item: item)
                }.padding().background(Color.green).clipShape(Circle()).foregroundColor(.white)
                
            }
            
           
            Button("Order this"){
                order.add(item: item)
            }.font(.headline)
            
            Spacer()
        }.navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetail(item:MenuItem.example).environmentObject(Order())
        }
    }
}

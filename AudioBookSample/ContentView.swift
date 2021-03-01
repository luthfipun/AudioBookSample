//
//  ContentView.swift
//  AudioBookSample
//
//  Created by Luthfi Abdul Azis on 26/02/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var data: Datas = DataSources().getData()
    @ObservedObject var globalState = GlobalState()
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ZStack {
                ParentView()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        Header()
                        History(histories: data.history, globalState: globalState, namespace: namespace)
                        Spacer(minLength: 18)
                        TopBook(top: data.top, globalState: globalState, namespace: namespace)
                    }
                }
            }
        }
        .overlay(globalState.isClicked ? DetailView(globalState: globalState, namespace: namespace) : nil)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardLarge: View {
    
    @State var item: Item
    @ObservedObject var globalState: GlobalState
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                
                let scale = getScale(proxy: proxy)
                
                Image("\(item.cover)")
                    .resizable()
                    .matchedGeometryEffect(id: "covers\(item.id)", in: namespace)
                    .frame(width: 150, height: 224)
                    .cornerRadius(12, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 1, y: 1)
                    .scaleEffect(CGSize(width: scale, height: scale))
                    .overlay(
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .matchedGeometryEffect(id: "btnPlay\(item.id)", in: namespace)
                                .frame(width: 40, height: 40, alignment: .bottomTrailing)
                                .overlay(Blur(style: .systemMaterial))
                                .foregroundColor(.black)
                                .opacity(0.2)
                                .cornerRadius(100)
                                .padding()
                                .background(
                                    Image("play")
                                        .matchedGeometryEffect(id: "play\(item.id)", in: namespace)
                                )
                        }
                        .frame(maxWidth: 150, maxHeight: 224, alignment: .bottomTrailing)
                    )
                
            }
            .frame(width: 150, height: 224)
        }.padding(.horizontal, 5)
        .animation(.spring())
        .onTapGesture {
            withAnimation {
                self.globalState.isHistory = true
                self.globalState.isClicked = true
                self.globalState.item = item
            }
        }
    }
}

struct Header: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Audio")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Text("Book")
                .font(.title)
                .foregroundColor(.white)
                .opacity(0.5)
            Spacer()
        }
        .padding()
        .frame(height: 100, alignment: .bottomLeading)
    }
}

struct History: View {
    
    @State var histories = [Item]()
    @ObservedObject var globalState: GlobalState
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            Text("Continue Listening")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(histories, id: \.self.id) { item in
                        CardLarge(item: item, globalState: globalState, namespace: namespace)
                    }
                }.padding()
            }
            .frame(height: 230)
        }
    }
}

struct CardSmall: View {
    
    @State var item: Item
    @ObservedObject var globalState: GlobalState
    var namespace: Namespace.ID
    
    var body: some View {
        HStack {
            Image("\(item.cover)")
                .resizable()
                .matchedGeometryEffect(id: "cover\(item.id)", in: namespace)
                .frame(width: 80, height: 112, alignment: .center)
                .cornerRadius(8, antialiased: true)
                .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 1, y: 1)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(item.title)
                    .font(.callout)
                    .bold()
                    .foregroundColor(.white)
                    .matchedGeometryEffect(id: "title\(item.id)", in: namespace)
                
                Spacer()
                
                Text(item.author)
                    .matchedGeometryEffect(id: "author\(item.id)", in: namespace)
                    .font(.callout)
                    .foregroundColor(.white)
                    .opacity(0.7)
                
                Spacer()
                
                HStack (spacing: 0) {
                    Text("$\(String.init(format: "%.0f", item.price))")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                    
                    Image("Star")
                        .matchedGeometryEffect(id: "star\(item.id)", in: namespace)
                        .padding(.trailing, 8)
                    
                    Text(String.init(format: "%.0f", item.rate))
                        .font(.callout)
                        .bold()
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "rate\(item.id)", in: namespace)
                    
                    Text("(88)")
                        .font(.callout)
                        .foregroundColor(.white)
                        .opacity(0.3)
                        .matchedGeometryEffect(id: "count\(item.id)", in: namespace)
                    
                    Spacer()
                }
            }.padding()
            
        }.padding(.horizontal, 16)
        .padding(.vertical, 3)
        .animation(.spring())
        .onTapGesture {
            withAnimation {
                self.globalState.isHistory = false
                self.globalState.isClicked = true
                self.globalState.item = item
            }
        }
    }
}

struct TopBook: View {
    
    @State var top = [Item]()
    @ObservedObject var globalState: GlobalState
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            Text("Top Books")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 12)
            
            ForEach(top, id: \.self.id) { item in
                CardSmall(item: item, globalState: globalState, namespace: namespace)
            }
        }
    }
}

struct ParentView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(Color("Orange"))
                .frame(maxWidth: .infinity, maxHeight: 200)
            
            Rectangle()
                .foregroundColor(Color("Purple"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

private func getScale(proxy: GeometryProxy) -> CGFloat {
    var scale: CGFloat = 1
    
    let x = proxy.frame(in: .global).minX
    
    let diff = abs(x)
    if diff < 100 {
        scale = 1 + (100 - diff) / 500
    }
    
    return scale
}

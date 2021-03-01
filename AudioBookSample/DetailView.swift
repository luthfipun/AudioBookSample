//
//  DetailView.swift
//  AudioBookSample
//
//  Created by Luthfi Abdul Azis on 27/02/21.
//

import SwiftUI
import SwiftUIX

struct DetailView: View {
    
    @ObservedObject var globalState: GlobalState
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            VStack {
                Image("\(globalState.item?.cover ?? "thumb1")")
                    .resizable()
                    .matchedGeometryEffect(id: globalState.isHistory ? "covers\(globalState.item?.id ?? 0)" : "cover\(globalState.item?.id ?? 0)", in: namespace)
                    .scaledToFill()
                    .frame(height: 500, alignment: .center)
                    .clipped()
                    .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                
                Spacer()
            }
            
            VStack(spacing: 0) {
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 80, alignment: .center)
                        .matchedGeometryEffect(id: globalState.isHistory ? "btnPlay\(globalState.item?.id ?? 0)" : "btnPlay" , in: namespace)
                        .overlay(Blur(style: .systemMaterial))
                        .foregroundColor(.black)
                        .opacity(0.2)
                        .cornerRadius(100)
                        .background(
                            Image("bigPlay")
                                .matchedGeometryEffect(id: globalState.isHistory ? "play\(globalState.item?.id ?? 0)" : "play", in: namespace)
                        )
                }.padding(.vertical, 20)
                
                Text(globalState.item?.title ?? "Unknown")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .matchedGeometryEffect(id: globalState.isHistory ? "title" : "title\(globalState.item?.id ?? 0)", in: namespace)
                
                Text(globalState.item?.author ?? "Unknown")
                    .font(.callout)
                    .opacity(0.5)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .matchedGeometryEffect(id: globalState.isHistory ? "author" : "author\(globalState.item?.id ?? 0)", in: namespace)
                
                HStack {
                    Image("Star")
                        .matchedGeometryEffect(id: globalState.isHistory ? "star" : "star\(globalState.item?.id ?? 0)", in: namespace)
                    
                    Text(String.init(format: "%.0f", globalState.item?.rate ?? 0.0))
                        .font(.callout)
                        .bold()
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: globalState.isHistory ? "rate" : "rate\(globalState.item?.id ?? 0)", in: namespace)
                    
                    Text("(88)")
                        .font(.callout)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .opacity(0.3)
                        .matchedGeometryEffect(id: globalState.isHistory ? "count" : "count\(globalState.item?.id ?? 0)", in: namespace)
                    
                }.padding(.vertical, 10)
            }
        }.ignoresSafeArea()
        .background(Color("Purple"))
        .animation(.spring())
        .onSwipeDown {
            withAnimation {
                globalState.isClicked = false
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        DetailView(globalState: GlobalState(), namespace: namespace)
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

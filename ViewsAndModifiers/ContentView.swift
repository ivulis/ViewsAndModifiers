//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by jazeps.ivulis on 24/08/2023.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var useRedText = false
    
    var motto1: some View {
        Text("Draco dormiens")
    }
    
    let motto2 = Text("nunquam titillandus")
    
    var spells: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    @ViewBuilder var greetings: some View {
        Text("Good")
        Text("Morning")
    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.green)
                .padding()
                .background(.blue)
                .watermarked(with: "This is a watermark")
            
            Button("Tap me") {
                print(type(of: self.body))
                useRedText.toggle()
            }
            .foregroundColor(useRedText ? .red : .blue)
            
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
            
            VStack {
                spells
            }
            
            HStack {
                spells
            }
            
            VStack {
                greetings
            }
            
            HStack {
                greetings
            }
            
            VStack(spacing: 10) {
                CapsuleText(text: "First")
                    .foregroundColor(.white)
                CapsuleText(text: "Second")
                    .foregroundColor(.yellow)
            }
            
            Text("Hello")
                .titleStyle()
        }
        
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

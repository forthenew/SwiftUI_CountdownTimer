//
//  ContentView.swift
//  CountdownTimerDemo
//
//  Created by stam on 2021/01/09.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 10
let lineWith: CGFloat = 30
let radius: CGFloat = 70

struct ContentView: View {
    
    @State private var isActive = false
    @State private var timeRemaing: CGFloat = defaultTimeRemaining
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                Circle()
                    .trim(from: 0, to: 1-((defaultTimeRemaining - timeRemaing)/defaultTimeRemaining))
                    .stroke(timeRemaing > 6 ? Color.green : timeRemaing > 3 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut)
                Text("\(Int(timeRemaing))").font(.largeTitle)
            }.frame(width: radius*2, height: radius*2)
            
            HStack(spacing: 25) {
                Label("\(isActive ? "Pause" : "Play")", systemImage: "\(isActive ? "pause.fill" : "play.fill" )").foregroundColor(isActive ? .red : .yellow).font(.title).onTapGesture {
                    isActive.toggle()
                }
                Label("Resume", systemImage: "backward.fill").foregroundColor(.black).font(.title).onTapGesture {
                    isActive = false
                    timeRemaing = defaultTimeRemaining
                }
            }.padding(.top, 50)
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaing > 0 {
                timeRemaing -= 1
            } else {
                isActive = false
                timeRemaing = defaultTimeRemaining
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

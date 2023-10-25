//
//  OnBoardingView.swift
//  SleepWell
//
//  Created by Muhammad Yusuf on 16/10/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var name: String = ""
    @State private var screen: Int = 1
    @State private var next: Bool = false
    @State private var isAlertPresented = false

    @State private var wakeTime: Date = Date()
    @State private var showingAlert = false
    @State private var sleepDuration: TimeInterval = 0
    @State private var averageSleepDuration = ""
    @ObservedObject private var sleepManager = SleepManager()
    
    var body: some View {
        ZStack {
            if screen == 12 {
                Text("screen 12")
            }
            Image("bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            switch screen {
            case 1:
                Screen1View(screen: $screen)
            case 2:
                PlanView(screen: $screen)
            case 3:
                TrackView(screen: $screen)
            case 4:
                RemindView(screen: $screen)
            case 5:
                Screen2View(screen: $screen, name: $name)
            case 6:
                Screen3View(screen: $screen, name: $name)
            case 7:
                Screen4View(screen: $screen, averageSleepDuration: $averageSleepDuration)
            case 8:
                Screen5View(screen: $screen, averageSleepDuration: $averageSleepDuration)
            case 9:
                Screen6View(screen: $screen)
            case 10:
                Screen7View(screen: $screen, name: $name, averageSleepDuration: $averageSleepDuration)
            case 11:
                HomeScreenView()
            default:
                EmptyView() // Handle cases where screen doesn't match any of the above
            }
        }
        .ignoresSafeArea(.keyboard)
        
    }
}

#Preview{
    OnBoardingView()
}
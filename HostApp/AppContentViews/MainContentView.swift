//
//  MainContentView.swift
//  CalendarWidget
//
//  Created by SmartLabs on 9/21/20.
//

import SwiftUI

/// Main view when the app launches
struct MainContentView: View {
    
    @ObservedObject var manager: WidgetManager
    @State private var gradientInstructions: Bool = false
    @State private var showPhotosPicker: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("My Calendar").font(.largeTitle).bold()
                    Text("Build your own calendar style").font(.system(size: 20)).opacity(0.5)
                }
                Spacer()
            }.padding(20)
            
            /// This is the actual widget view
            CalendarWidgetView(entry: CalendarEntry(date: Date()), manager: manager)
                .frame(height: 160).cornerRadius(20)
                .padding(.leading, 20).padding(.trailing, 20)
                .padding(.bottom, 30)
            
            /// Here are the modifiers/configurations for the widget
            ScrollView {
                TextAlignmentView
                TextColor
                TextFont
                BackgroundImage
                BackgroundGradient
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $gradientInstructions, content: {
            Alert(title: Text("How To"), message: Text("Double-Tap a color to confirm your selection, then proceed with the next color"), dismissButton: .cancel(Text("OK")))
        })
        .sheet(isPresented: $showPhotosPicker, content: {
            UnsplashImagePicker(didSelectImage: { image in
                manager.updateBackgroundImage(image)
            })
        })
    }
    
    /// Change text alignment
    private var TextAlignmentView: some View {
        VStack {
            modifierSection(title: "Text Alignment")
            Picker(selection: $manager.calendarTextAlignmentIndex, label: Text("Status")) {
                ForEach(0..<3, id: \.self, content: { index in
                    Text(index == 0 ? "Left" : index == 1 ? "Center" : "Right")
                })
            }
            .onChange(of: manager.calendarTextAlignmentIndex) { index in
                manager.updateTextAlignment(index: index)
            }
            .pickerStyle(SegmentedPickerStyle())
        }.padding(.leading, 20).padding(.trailing, 20)
    }
    
    /// Change text color
    private var TextColor: some View {
        colorSelector(title: "Text Color")
    }
    
    /// Change text font
    private var TextFont: some View {
        VStack {
            modifierSection(title: "Font Style").padding(.leading, 20).padding(.trailing, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    Spacer(minLength: -2)
                    ForEach(0..<manager.fonts.count, id: \.self, content: { index in
                        Button(action: {
                            manager.updateTextFont(index: index)
                        }, label: {
                            Text(manager.fonts[index]).font(.custom(manager.fonts[index], size: 20))
                                .foregroundColor(manager.selectedFont != manager.fonts[index] ? .black : .white)
                                .padding()
                        })
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(manager.selectedFont == manager.fonts[index] ? .black : .white))
                    })
                    Spacer(minLength: -2)
                }
            }
        }.padding(.top, 30)
    }
    
    /// Background gradient
    private var BackgroundGradient: some View {
        colorSelector(title: "Background Gradient", gradientSelector: true)
            .padding(.bottom, 30)
    }
    
    /// Background image
    private var BackgroundImage: some View {
        VStack {
            modifierSection(title: "Background Image")
            Button(action: {
                showPhotosPicker.toggle()
            }, label: {
                Image(uiImage: manager.backgroundImage ?? UIImage(named: "placeholder")!)
                    .resizable().aspectRatio(contentMode: .fill)
                    .frame(height: 120).clipped().cornerRadius(15)
            })
            Button(action: {
                manager.updateBackgroundImage(nil)
            }, label: {
                Text("Remove Image").foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
            }).padding(.top, 10)
        }
        .padding(.leading, 20).padding(.trailing, 20)
        .padding(.top, 30)
    }
}

// MARK: - Commong functions
extension MainContentView {
    private func modifierSection(title: String) -> some View {
        HStack {
            Text(title).foregroundColor(.secondary)
            Spacer()
        }
    }
    
    private func colorSelector(title: String, gradientSelector: Bool = false) -> some View {
        VStack {
            modifierSection(title: title).padding(.leading, 20).padding(.trailing, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    Spacer(minLength: 02)
                    ForEach(0..<manager.colors.count, id: \.self, content: { index in
                        Button(action: {
                            if !gradientSelector { manager.updateTextColor(index: index) } else {
                                if manager.shouldShowGradientTips {
                                    gradientInstructions.toggle()
                                } else {
                                    manager.updateGradientSelection(index: index)
                                }
                            }
                        }, label: {
                            ZStack {
                                Circle().stroke(index == 0 ? Color.secondary : Color.clear, lineWidth: 2)
                                    .background(manager.colors[index])
                                    .clipShape(Circle())
                                if gradientSelector {
                                    if manager.calendarGradientColors.contains(index) {
                                        Image(systemName: "checkmark").accentColor(.primary)
                                    }
                                } else {
                                    if manager.selectedTextColorIndex == index {
                                        Image(systemName: "checkmark").accentColor(.primary)
                                    }
                                }
                            }
                            .frame(width: 58, height: 60)
                        })
                    })
                    Spacer(minLength: -2)
                }
            }
        }.padding(.top, 30)
    }
}

// MARK: - Render the UI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(manager: WidgetManager())
    }
}

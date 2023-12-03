//
//  ContentView.swift
//  nabyeh
//
//  Created by لمى محمد البرادي  on 19/05/1445 AH.
//

import SwiftUI

struct ContentView: View {
    // state variable : progress used to mange the progress ,audioUrl used to selected audio URL ,isDocumentPickerPresented for document picker presentation
    @State private var progress : CGFloat = 0.0
    @State private var audioUrl : URL?
    @State private var isDocumentPickerPresented = false
    
    
    var body: some View {
        
        VStack {
            Spacer()
            
            //title of the app
            Text("AI Detection")
                .font(.title)
                .padding(.top, -80)
            
            //circular progress bar with dynamic progress
            CirculeProgressBar(progress: progress)
                .frame(width: 200, height: 200)
                .padding(.bottom,10 )
            
            //"check" button to initiate the detection process
            Button(action:{
                startDetection()
            }){
                Text("Check")
                    .font(.headline)
                    .padding()
                    .background(Color.Tiffany)
                    .cornerRadius(30)
                    .foregroundColor(.white)
                
            }
            .padding(.bottom , 10 )
            
            //horizontal stack containing the combined "Up" button and text field
            HStack{
                
                //ZStack to overlay the "Up" button on the text field
                ZStack (alignment:.trailing){
                    
                    // text field displaying the upload file name
                    TextField("upload file" , text:.constant(audioUrl?.lastPathComponent ?? ""))
                        .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding(.vertical , 10 )
                        .padding(.horizontal , 20)
                        .background(Color.lightGray)
                        .cornerRadius(50)
                        .foregroundColor(Color.DarkGray)
                    
                    //"Up" buttonto trigger the document picker
                    Button(action:  {
                        isDocumentPickerPresented.toggle()
                    }){
                        Text("UP")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical , 15)
                            .padding(.horizontal)
                    }
                    .background(Color.Tiffany)
                    .cornerRadius(60)
                }
            }
            .padding(.horizontal , 10 )
            
            Spacer()
              
        }
        .padding(.top , -40 )
        .fileImporter(isPresented: $isDocumentPickerPresented, allowedContentTypes: [.audio]){result in
            switch result{
            case.success(let url ):
                audioUrl = url
            case .failure(let error):
                print("file picking failed : \(error)")
            }
        }
}
    //placeholderfunction for the sound detection process
    private func startDetection(){
        progress = CGFloat.random(in: 0...1 )
    }
}
// circular progress bar view
struct CirculeProgressBar: View {
    var progress : CGFloat
    
    var body: some View{
        ZStack{
            
           // outer cilrcle light gray color
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color(UIColor.lightGray))
            
            //inner circle with dynamic progress and tiffany color
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to:progress)
                .stroke(style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                .rotation(Angle(degrees: 270.0))
                .animation(.linear)
            
            //text displaying the percentage of progress
            Text(String(format:"%0.0f%%", progress * 100.0 ))
                .font(.system(size: 30))
        }
    }
}

// extension defining custom colors
extension Color{

    static var Tiffany : Color {
        Color(red:0.278 , green: 0.847 , blue:0.780  )
    }
    
    static var lightGray : Color {
        Color(red:0.867 , green: 0.867 , blue:0.867  )
    }
    
    static var DarkGray : Color {
        Color(red:0.6157 , green: 0.6157 , blue:0.6157  )
    }
}

// preview provider for swiftUI previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

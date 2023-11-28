//
//  ContentView.swift
//  First_design
//
//  Created by لمى محمد البرادي  on 14/05/1445 AH.
//
import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 0.0 // You can set the initial progress here
    @State private var audioURL: URL?
    @State private var isDocumentPickerPresented = false

    var body: some View {
        VStack {
            Spacer() // Push contents to the top

            Text("AI Detection")
                .font(.title)
                .padding(.top, -80)

            CircleProgressBar(progress: progress)
                .frame(width: 200, height: 200) // Adjust the size as needed
                .padding(.bottom, 10) // Adjust the bottom padding

            Button(action: {
                // Action to be performed when the button is tapped
                startDetection()
            }) {
                Text("Check")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.lightBlueGreen) // Lighter blue-green color
                    .cornerRadius(30)
            }
            .padding(.bottom, 10) // Add space between Check button and TextField

            HStack {
                Spacer() // Push contents to the left

                TextField("Uploaded file", text: .constant(audioURL?.lastPathComponent ?? ""))
                    .disabled(true)
                    .multilineTextAlignment(.center) // Center the text
                    .padding(10)
                    .background(Color.lighterGray) // Lighter gray background
                    .cornerRadius(70)

                Spacer() // Push contents to the right

                Button(action: {
                    // Action to be performed when the "Up" button is tapped
                    isDocumentPickerPresented.toggle()
                }) {
                    Text("Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                }
                .background(Color.lightBlueGreen) // Lighter blue-green color
                .cornerRadius(70)
            }
            .padding(.horizontal, 10) // Add horizontal padding to center-align the HStack

            Spacer() // Push contents to the bottom

            // Add your other SwiftUI views/content here
        }
        .padding(.top, -40)
        .fileImporter(isPresented: $isDocumentPickerPresented, allowedContentTypes: [.audio]) { result in
            switch result {
            case .success(let url):
                // Handle the selected audio file URL
                audioURL = url
            case .failure(let error):
                // Handle the error
                print("File picking failed: \(error)")
            }
        }
    }

    private func startDetection() {
        // Placeholder for the sound detection process
        // You can add your logic here to update the progress value
        progress = CGFloat.random(in: 0...1)
    }
}

struct CircleProgressBar: View {
    var progress: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .opacity(0.3)
                .foregroundColor(Color(UIColor.lightGray)) // Light gray color

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.lightBlueGreen) // Lighter blue-green color
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text(String(format: "%0.0f%%", progress * 100.0))
                .font(.system(size: 30))
        }
    }
}

extension Color {
    static var lightBlueGreen: Color {
        Color(red: 0.5, green: 0.8, blue: 0.8) // Adjust the values for a lighter blue-green shade
    }

    static var lighterGray: Color {
        Color(UIColor.lightGray.withAlphaComponent(0.3)) // Adjust the alpha component for a lighter gray shade
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

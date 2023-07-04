import SwiftUI

struct MediaGalleryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedMedia: [String]

    var body: some View {
        NavigationView {
            VStack {
                // Display your media gallery content here
                // For example, a grid view of available media options
                // Each option can be a selectable view

                // Example grid view
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(allMediaOptions, id: \.self) { mediaOption in
                        Button(action: {
                            toggleMediaSelection(mediaOption)
                        }) {
                            Image(mediaOption)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedMedia.contains(mediaOption) ? Color.blue : Color.clear, lineWidth: 2)
                                )
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Media Gallery", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    // Action for saving the selected media and dismissing the view
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
                .disabled(selectedMedia.isEmpty)
            )
        }
    }

    // Array of all available media options
    let allMediaOptions: [String] = [
        "media1",
        "media2",
        "media3",
        // Add more media options as needed
    ]

    // Toggle the selection of a media option
    func toggleMediaSelection(_ mediaOption: String) {
        if selectedMedia.contains(mediaOption) {
            selectedMedia.removeAll { $0 == mediaOption }
        } else {
            selectedMedia.append(mediaOption)
        }
    }
}

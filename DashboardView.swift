import SwiftUI
import UniformTypeIdentifiers

struct DashboardView: View {
    @State private var importing = false
    @State private var files: [URL] = []

    var body: some View {
        NavigationStack {
            List {
                Section("Daten") {
                    Button("Dateien hinzufügen", systemImage: "doc.badge.plus") {
                        importing = true
                    }
                    Button("Ordner hinzufügen", systemImage: "folder.badge.plus") {
                        importing = true
                    }
                }

                Section("Projekt") {
                    Text("\(files.count) Quellen importiert")
                }
            }
            .navigationTitle("SQLite Recovery AI")
            .fileImporter(
                isPresented: $importing,
                allowedContentTypes: [.data, .folder, .json, .xml],
                allowsMultipleSelection: true
            ) { result in
                if case .success(let urls) = result {
                    files.append(contentsOf: urls)
                }
            }
        }
    }
}

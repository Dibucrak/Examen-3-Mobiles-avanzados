import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var teachers: [Docente]
    @State private var searchText = ""
    @State private var showingAddForm = false

    var filteredTeachers: [Docente] {
        if searchText.isEmpty {
            return teachers
        } else {
            return teachers.filter {
                $0.firstName.lowercased().contains(searchText.lowercased()) ||
                $0.lastName.lowercased().contains(searchText.lowercased()) ||
                $0.email.lowercased().contains(searchText.lowercased()) ||
                $0.specialization.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if teachers.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.square")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("No hay docentes aún")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Toca el botón + para agregar tu primer docente")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(filteredTeachers) { teacher in
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(teacher.firstName) \(teacher.lastName)")
                                        .font(.headline)
                                    if !teacher.specialization.isEmpty {
                                        Text(teacher.specialization)
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                    if !teacher.email.isEmpty {
                                        Text(teacher.email)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Docentes")
            .searchable(text: $searchText, prompt: "Buscar docentes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $showingAddForm) {
                AddTeacherView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Docente.self, inMemory: true)
}

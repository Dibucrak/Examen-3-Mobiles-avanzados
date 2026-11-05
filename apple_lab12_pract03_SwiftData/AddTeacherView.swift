import SwiftUI
import SwiftData

struct AddTeacherView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var dateOfBirth = Date()
    @State private var specialization = ""
    @State private var hireDate = Date()
    @State private var isActive = true

    var body: some View {
        NavigationView {
            Form {
                Section("PERSONAL INFORMATION") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                }

                Section("PROFESSIONAL INFORMATION") {
                    TextField("Specialization", text: $specialization)
                    DatePicker("Hire Date", selection: $hireDate, displayedComponents: .date)
                    Toggle("Active", isOn: $isActive)
                }
            }
            .navigationTitle("Add Teacher")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveTeacher()
                    }
                    .disabled(firstName.trimmingCharacters(in: .whitespaces).isEmpty ||
                              lastName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func saveTeacher() {
        let teacher = Docente()
        teacher.firstName = firstName.trimmingCharacters(in: .whitespaces)
        teacher.lastName = lastName.trimmingCharacters(in: .whitespaces)
        teacher.email = email.trimmingCharacters(in: .whitespaces)
        teacher.phone = phone.trimmingCharacters(in: .whitespaces)
        teacher.dateOfBirth = dateOfBirth
        teacher.specialization = specialization.trimmingCharacters(in: .whitespaces)
        teacher.hireDate = hireDate
        teacher.isActive = isActive
        modelContext.insert(teacher)
        dismiss()
    }
}

#Preview {
    AddTeacherView()
        .modelContainer(for: Docente.self, inMemory: true)
}

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
        Form {
            Section("INFORMACIÓN PERSONAL") {
                TextField("Nombre", text: $firstName)
                TextField("Apellido", text: $lastName)
                TextField("Correo electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("Teléfono", text: $phone)
                    .keyboardType(.phonePad)
                DatePicker("Fecha de nacimiento", selection: $dateOfBirth, displayedComponents: .date)
            }

            Section("INFORMACIÓN PROFESIONAL") {
                TextField("Especialización", text: $specialization)
                DatePicker("Fecha de contratación", selection: $hireDate, displayedComponents: .date)
                Toggle("Activo", isOn: $isActive)
            }
        }
        .navigationTitle("Agregar docente")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Guardar") {
                    saveTeacher()
                }
                .disabled(firstName.trimmingCharacters(in: .whitespaces).isEmpty ||
                          lastName.trimmingCharacters(in: .whitespaces).isEmpty)
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

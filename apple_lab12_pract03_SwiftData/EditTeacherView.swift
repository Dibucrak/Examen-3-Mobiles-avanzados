import SwiftUI
import SwiftData

struct EditTeacherView: View {
    var teacher: Docente
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var phone: String
    @State private var dateOfBirth: Date
    @State private var specialization: String
    @State private var hireDate: Date
    @State private var isActive: Bool

    init(teacher: Docente) {
        self.teacher = teacher
        _firstName = State(initialValue: teacher.firstName)
        _lastName = State(initialValue: teacher.lastName)
        _email = State(initialValue: teacher.email)
        _phone = State(initialValue: teacher.phone)
        _dateOfBirth = State(initialValue: teacher.dateOfBirth)
        _specialization = State(initialValue: teacher.specialization)
        _hireDate = State(initialValue: teacher.hireDate)
        _isActive = State(initialValue: teacher.isActive)
    }

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

            Section {
                Button("Eliminar docente") {
                    deleteTeacher()
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Editar docente")
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
        teacher.firstName = firstName.trimmingCharacters(in: .whitespaces)
        teacher.lastName = lastName.trimmingCharacters(in: .whitespaces)
        teacher.email = email.trimmingCharacters(in: .whitespaces)
        teacher.phone = phone.trimmingCharacters(in: .whitespaces)
        teacher.dateOfBirth = dateOfBirth
        teacher.specialization = specialization.trimmingCharacters(in: .whitespaces)
        teacher.hireDate = hireDate
        teacher.isActive = isActive
        dismiss()
    }

    private func deleteTeacher() {
        modelContext.delete(teacher)
        dismiss()
    }
}

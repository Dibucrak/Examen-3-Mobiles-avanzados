import Foundation
import SwiftData

@Model
final class Docente {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phone: String = ""
    var dateOfBirth: Date = Date()
    var specialization: String = ""
    var hireDate: Date = Date()
    var isActive: Bool = true

    init() {}
}

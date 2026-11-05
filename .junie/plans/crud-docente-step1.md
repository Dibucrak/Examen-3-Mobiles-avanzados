---
sessionId: session-261105-165254-7j31
---

# Requirements

### Overview
Implement Step 1 of the CRUD Docente lab: the main Teachers list page and the Add Teacher form using SwiftData and SwiftUI for iPhone.

### Scope
**In Scope:**
- `Docente` SwiftData model with all fields from the create form
- Main page with "Teachers" title, search bar placeholder, "+" button, and empty list state
- Add Teacher form with two sections:
  - **Personal Information**: First Name, Last Name, Email, Phone, Date of Birth
  - **Professional Information**: Specialization, Hire Date, Active toggle
- Save and Cancel actions on the form
- List saved teachers on the main page (name, specialization, email)
- Update `ModelContainer` to use `Docente` instead of `Item`

**Out of Scope:**
- Search functionality (Step 2)
- Edit teacher (Step 3)
- Delete teacher with swipe (Step 3)

### Expected UI
- **Main Page**: Title "Teachers", search bar with placeholder "Search teachers...", "+" button top-right, list of teachers or empty state
- **Add Teacher Page**: Title "Add Teacher", Cancel/Save buttons, form fields organized in two sections with section headers

# Technical Design

### Current Implementation
The project is a Xcode SwiftUI template with SwiftData:
- `Item.swift` — basic model with only `timestamp: Date`
- `ContentView.swift` — generic list view with `NavigationSplitView`
- `apple_lab12_pract03_SwiftDataApp.swift` — app entry point with `ModelContainer` for `Item`

### Proposed Changes

**1. New `Docente` model (`Docente.swift`)**
Replace `Item.swift` with a new `@Model` class:
```swift
@Model final class Docente {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phone: String = ""
    var dateOfBirth: Date = Date()
    var specialization: String = ""
    var hireDate: Date = Date()
    var isActive: Bool = true
}
```

**2. Update `ContentView.swift` — Main Teachers List**
- Replace `NavigationSplitView` with `NavigationView` (iPhone only)
- Title "Teachers"
- Search bar (static for now, no filtering logic yet)
- "+" button that navigates to the create form
- `List` showing teachers with `firstName lastName`, `specialization` (blue), and `email` (gray)
- Empty state when no teachers exist

**3. New `AddTeacherView.swift` — Create Form**
- Form with two `Section`s:
  - "PERSONAL INFORMATION" — TextFields for firstName, lastName, email, phone + DatePicker for dateOfBirth
  - "PROFESSIONAL INFORMATION" — TextField for specialization, DatePicker for hireDate, Toggle for isActive
- `@Environment(\.dismiss)` to handle Cancel
- `@Environment(\.modelContext)` to save on Save
- Validation: Save only if firstName and lastName are not empty

**4. Update `apple_lab12_pract03_SwiftDataApp.swift`**
- Change `Schema` to use `Docente.self` instead of `Item.self`

**5. Remove `Item.swift`**
- Delete the old model file

### File Structure
- **New**: `Docente.swift` — SwiftData model
- **New**: `AddTeacherView.swift` — Create form view
- **Modified**: `ContentView.swift` — Main list page
- **Modified**: `apple_lab12_pract03_SwiftDataApp.swift` — ModelContainer update
- **Deleted**: `Item.swift` — Old model

# Delivery Steps

### ✓ Step 1: Create Docente model and update app entry point
- Create `Docente.swift` with all 8 fields (firstName, lastName, email, phone, dateOfBirth, specialization, hireDate, isActive)
- Update `apple_lab12_pract03_SwiftDataApp.swift` to use `Docente.self` in the Schema
- Remove `Item.swift` as it's no longer needed

### ✓ Step 2: Implement main Teachers list page
Transform ContentView into the main Teachers list page.
- Replace NavigationSplitView with NavigationView for iPhone
- Add 'Teachers' title, search bar placeholder, and '+' button
- Display teachers in a List showing name (bold), specialization (blue), and email (gray)
- Show empty state when no teachers exist
- Add NavigationLink to AddTeacherView from the '+' button

### ✓ Step 3: Implement Add Teacher form
Create the AddTeacherView with a complete form for creating new teachers.
- Create `AddTeacherView.swift` with two sections: Personal Information and Professional Information
- Add TextFields, DatePickers, and Toggle for all fields
- Implement Cancel (dismiss) and Save (validate + persist to SwiftData) actions
- Validate that firstName and lastName are not empty before saving
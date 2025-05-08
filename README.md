# AI-Twin

**AI-Twin** is an iOS test project built to demonstrate a small AI interaction session manager.

The app allows users to:
✅ View a list of past sessions of interaction with an AI twin
✅ Create new sessions
✅ View a simple emulated chat session

---

## 🧱 Architecture

AI-Twin follows the **MVVM (Model-View-ViewModel)** pattern:

- **Model**: Includes `Session` struct and `SessionEntity` (Core Data).
- **ViewModel**: `SessionsViewModel` handles data fetching, local caching, and business logic.
- **View**: SwiftUI views render session lists, session creation, and chat emulation.

Additional architectural components:
- **CoreDataManager**: Singleton for managing Core Data operations.
- **SessionService**: Handles API calls using `async/await`.

---

## 🚀 How to Run

1. Clone the repo: git clone https://github.com/ChirvaDev/AI-Twin.git
2. Open the project in Xcode 14 or newer.
3. Make sure the deployment target is set to iOS 16.0 or higher.
4. Build and run the project using the iOS Simulator or a physical device.
5. No third-party dependencies are required. The project uses only native Apple frameworks.
6. If needed, you can replace the mock API URL in SessionService.swift with your own Mocky.io endpoint or local JSON.

---

🧪 Testing Mock Data

The app fetches sessions from a mock API hosted via Mocky.io.
Example endpoint:
https://run.mocky.io/v3/d9796311-5e1a-40fc-bb23-3ef392a4b402

The response must be a JSON array of sessions with the following structure:
 {
    "id": "1",
    "date": "2025-05-01",
    "title": "Work Goals Review",
    "category": "career",
    "summary": "Discussed progress and planned next steps for career growth."
  }
  
---

💡 Ideas for Improvement

✅ Better chat emulation UI (e.g., AI response animations).
🔄 Add persistent syncing with real API.
🔍 Add search and filtering by date/category.
💾 Export/import session history.
🧪 Unit testing for ViewModels and data layer.
🌍 Multi-language support (e.g., English, Ukrainian).
👥 Multi-profile support with personalized AI twins.
☁️ iCloud sync for cross-device history.
   

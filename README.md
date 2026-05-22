# 🌍 Global Countries Directory

A lightweight, high-performance native iOS application built using **SwiftUI** and modern architecture patterns. The app consumes a live REST API to browse countries, filter records instantly via a native search engine, and display granular geographic, financial, and regional analytics in a beautiful card-based layout.

---

## 📱 Screenshots

| Main List | Search View | Details View |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/dd3ef66b-427a-465a-bf7f-61649ce98ed8" width="280" alt="Main List Screen"/> | <img src="https://github.com/user-attachments/assets/18bb8916-628a-41cc-bf66-6f0a66ec0471" width="280" alt="Search Screen"/> | <img src="https://github.com/user-attachments/assets/70294b7b-943a-4e96-9617-93a8f53930b4" width="280" alt="Detail Card Screen"/> |
| *Native list view with remote flag caching* | *Real-time localized case-insensitive filtering* | *Rich card layout handling complex nested objects* |

---

## 🛠️ Key Technical Features

- **Declarative Architecture (MVVM):** Powered entirely by Apple's cutting-edge `@Observable` macro system for memory-efficient tracking and localized rendering passes.
- **Modern Concurrency Control:** Implements clean `async/await` background fetch states through structured `URLSession` data pipelines.
- **Type-Safe Decoding Framework:** Maps deeply nested JSON properties (including dynamic arrays like local currency variants and custom asset objects) effortlessly using `Codable` and `Hashable` configurations.
- **Bulletproof Error Subsystems:** Features typed domain-specific execution states via a custom `ErrorsEnum` to intelligently trap invalid server status handling or bad configuration states.
- **Asynchronous Asset Pipeline:** Utilizes explicit non-blocking background threads to capture, downsample, and present web-hosted flags (`AsyncImage`) on-demand.
- **Rich Native UX:** Built-in system capabilities like Pull-to-Refresh (`.refreshable`) and dynamic string indexing mapping (`.searchable`).

---

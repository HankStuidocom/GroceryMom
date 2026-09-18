# 🛒 GroceryMom — Household Grocery & Budget Manager

**GroceryMom** is a modern, cross-platform web and mobile application designed to help homemakers and families plan grocery shopping, organize pantries, and track monthly household budgets effortlessly.

[![Live Demo](https://img.shields.io/badge/Live_Demo-Vercel-000000?style=for-the-badge&logo=vercel)](https://grocery-mom-app.vercel.app)
[![React](https://img.shields.io/badge/React_19-61DAFB?style=for-the-badge&logo=react&logoColor=black)](https://react.dev)
[![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org)
[![Capacitor](https://img.shields.io/badge/Capacitor_8-119EFF?style=for-the-badge&logo=capacitor&logoColor=white)](https://capacitorjs.com)

---

## 🌟 Features

- **Smart Dashboard & Budget Tracking**
  - Set monthly budget targets and track real-time spent vs. remaining funds.
  - Interactive budget ring charts with live percentage indicators.
  - Interactive Month & Year selector to inspect past and upcoming budgets.

- **Grocery Runs & Item Management**
  - Create grocery runs with budget validation and custom start dates.
  - Add items organized by categories (Dairy & Eggs, Fresh Fruits, Vegetables, Pantry, etc.) with quantities and prices.
  - Interactive check-off items while shopping with live progress indicators.

- **Expense History & Ledgers**
  - Year-to-Date (YTD) expense summaries, average monthly spend, and best/highest spending months.
  - Filter historical ledgers by year or view all-time summaries.
  - Expandable multi-run views and detailed category spending breakdowns.

- **Notifications & Offline Reminders**
  - Notification panel for Weekly & Monthly grocery reminders and Over-Budget alerts.
  - Offline native Android system popup notifications powered by `@capacitor/local-notifications`.

- **Cross-Platform & Cloud Sync**
  - Real-time cloud sync powered by Firebase Firestore with automatic offline `localStorage` fallback.
  - Works as a Progressive Web App (PWA) and a native Android application (.apk).

---

## 🛠️ Tech Stack

- **Frontend**: React 19, TypeScript, Vite, Tailwind CSS v4, Motion, Lucide Icons
- **Mobile**: Capacitor 8 (`@capacitor/android`, `@capacitor/local-notifications`)
- **Backend & Cloud**: Firebase (Firestore), Vercel Deployment

---

## 📁 Project Structure

```text
Grocery List/
├── android/                   # Capacitor Android Native Project
├── public/                    # Static assets (logo.png, favicon.png)
├── src/
│   ├── components/            # UI Components
│   │   ├── ActiveListView.tsx # Active grocery run shopping interface
│   │   ├── AddItemModal.tsx   # Add/Edit grocery item modal
│   │   ├── Header.tsx         # Header with Notification Panel
│   │   ├── HistoryView.tsx    # Expense history & YTD summary
│   │   ├── HomeView.tsx       # Main dashboard card & month picker
│   │   ├── MonthSummaryModal.tsx # Detailed monthly wrap-up report
│   │   ├── NewMonthModal.tsx  # Create grocery run modal
│   │   └── SettingsView.tsx   # User profile & notification settings
│   ├── data/                  # Initial data & app configurations
│   ├── types/                 # TypeScript interfaces & types
│   ├── utils/                 # Formatting & notification helpers
│   ├── App.tsx                # Main App Entrypoint
│   └── main.tsx               # Vite Mounting Point
├── capacitor.config.json      # Capacitor App Configuration
├── package.json               # Dependencies & Scripts
└── vite.config.ts             # Vite Configuration
```

---

## 🚀 Getting Started

### Prerequisites
- Node.js (v18 or higher)
- npm or yarn
- Android Studio (for building Android APK)

### 1. Installation
Clone the repository and install dependencies:
```bash
git clone https://github.com/your-username/grocery-mom.git
cd grocery-mom
npm install
```

### 2. Running Locally
Start the Vite development server:
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) in your browser.

### 3. Build for Web
Build the production-ready static assets:
```bash
npm run build
```

---

## 📱 Building Android APK

1. **Build web bundle & sync Capacitor Android project:**
   ```bash
   npm run android:sync
   ```

2. **Open the Android project in Android Studio:**
   ```bash
   npm run android
   ```
   *(or `npx cap open android`)*

3. **Generate APK in Android Studio:**
   - Go to **Build** ➔ **Build Bundle(s) / APK(s)** ➔ **Build APK(s)**.
   - Once completed, click **"locate"** in the bottom-right notification popup to get your `.apk` file.

---

## ☁️ Deployment

Deploy to Vercel production:
```bash
npx vercel --prod
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


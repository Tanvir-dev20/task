# 🛍️ Product List App

A Flutter application built as part of **Task 2** to demonstrate REST API handling, async operations, list building, search and category filtering with basic state management.

## 📋 Features
- Fetch products from [FakeStore API](https://fakestoreapi.com/products)
- Display products in a List with image and title
- Search bar to filter products by title (case-insensitive)
- Dropdown filter for product categories (e.g. men's clothing, jewelery)
- Reactive UI with **GetX** state management
- Skeleton loader (Shimmer) while loading data

## 🏗️ Tech Stack
- **Flutter** (latest stable)
- **GetX** for state management
- **HTTP** for API calls
- **Shimmer** for loading skeleton

## 📂 Folder Structure
lib/
├─ controller/
│ └─ product_list_controller.dart
├─ data/
│ └─ services/api_caller.dart
├─ view/
│ └─ product_list_screen.dart
└─ main.dart


## ⚙️ How it Works
- `ProductListController` fetches products from the API and stores them in an observable list.
- Search input updates the list in real-time.
- Dropdown allows filtering by category.
- UI (ProductListScreen) listens to the observable lists using `Obx` and updates automatically.

## 🚀 Getting Started
1. Clone the repository
2. Run `flutter pub get`
3. Run the app: `flutter run`

## 📝 Notes
- API: [https://fakestoreapi.com/products](https://fakestoreapi.com/products)
- Add your own categories in the controller if needed
- This is a demo project for learning purposes

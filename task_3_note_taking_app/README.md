# 📝 Flutter Notes App (GetX + Clean Architecture)

A simple note-taking application built with **Flutter**, **GetX**, and **Clean Architecture**.  
The app stores notes locally in **SharedPreferences** and works in **offline-first** mode.  
When the device has internet connectivity, notes are automatically synced to [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts) via POST.

---

##  Features

-  Create new notes  
-  Edit existing notes  
-  Delete notes  
-  Pick a color tag for each note  
-  Toggle dark/light mode  
-  Offline-first: notes are saved locally first, then synced when online  

---

##  Architecture

The project follows **Clean Architecture** and is split into three layers:

- **domain** — entities, repository contracts, and use cases  
- **data** — local data source (SharedPreferences), remote data source (HTTP API), repository implementation  
- **presentation** — GetX controllers, bindings, UI pages & widgets  

Folder structure:


# 🎬 AI Movie Recommender App

An intelligent movie recommendation app built with **Flutter**, **BLoC**, and **Clean Architecture**, powered by **The Movie DB API** and **OpenRouter AI** 🤖🍿.

🚀 Get movie recommendations, explore trending titles, and chat with an AI to discover what to watch next!

---

## ✨ Features

- 🔍 **Smart Chat Assistant** – Powered by OpenRouter to give you intelligent movie suggestions.
- 🎬 **Movie Details** – Explore movie info, posters, and summaries via TMDB API.
- 🧠 **BLoC + Clean Architecture** – Built following scalable architecture principles.
- 🎨 **Animated UI** – Smooth animations with `FadeAnimations`, `Hero`, and more.
- 🧭 **Custom Bottom Navigation** – Designed using advanced `ClipPath` for a unique look.
- 🎥 **Demo Video Included** – Check out the full app walkthrough!

---

## 📽️ Demo Video

🎥 Watch the complete demo (3:53):  
👉 [Insert your video link here]

---

## 🛠 Installation Guide

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/yourusername/ai_movie_recommender_app.git
cd ai_movie_recommender_app
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Set Up Environment Variables

Create a `.env` file in the root directory:

```env
TMDB_API_KEY=your_tmdb_api_key
OPENROUTER_API_KEY=your_openrouter_api_key
TMDB_TOKEN=your_tmdb_token
```

And use [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) to load them.

### 4️⃣ Run the App

```bash
flutter run
```

---

## 📦 Dependencies

This app uses the following key packages:

- `flutter_bloc` – Robust state management 🧩
- `flutter_dotenv` – Manage environment variables securely 🔐
- `flutter_staggered_grid_view` – Responsive layout for movie grids 🧱
- `loading_animation_widget` – Clean and customizable loading effects ⏳
- `http` – API calls to TMDB and OpenRouter 🌐

---

## 🗂️ Project Structure

```
lib/
├── core/             # Shared logic & constants
├── data/             # API services and models
├── domain/           # Business logic, use cases
├── presentation/     # UI, widgets, screens
├── app.dart          # Main MaterialApp setup
└── main.dart         # Entry point
```

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create a new branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Create a Pull Request

---

## 📝 License

This project is licensed under the MIT License – see the LICENSE file for details.

---

## 🙏 Acknowledgments

- [The Movie DB](https://www.themoviedb.org/) for movie data 📊
- [OpenRouter](https://openrouter.ai/) for AI-powered chat 💬
- The Flutter community for amazing tools & support 🧡

---

## 📞 Contact

**Deo Gratias PATINVOH**  
📧 deogratiaspatinvoh@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/deo-gratias-patinvoh-975554238/)
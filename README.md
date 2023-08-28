# Tijara E-Commerce App 

This repository contains Tijara, an E-Commerce mobile application built using Flutter and Firebase, with state management handled by the Provider package. Tijara allows users to browse products, add them to a shopping cart, and complete the checkout process.

## Features

- User authentication: Users can sign up, log in, and log out.
- Product browsing: Users can view a list of products, search for specific products, and view product details.
- Shopping cart: Users can add products to their cart, view the cart contents, update quantities, and remove items.
- Checkout process: Users can proceed to checkout, enter shipping and payment information, and complete the purchase.
- Order history: Users can view their past orders and order details.
- Firebase integration: The app utilizes Firebase for user authentication, product storage, and order management.

## Prerequisites

To run Tijara locally, you need to have the following installed:

- Flutter SDK: [Installation Guide ↗](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Installation Guide ↗](https://dart.dev/get-dart)
- Firebase account: [Sign up for Firebase ↗](https://firebase.google.com/)

## Getting Started

1. Clone this repository to your local machine:

```bash
git clone https://github.com/abdallah116294/Tijara
```

2. Change into the project directory:

```bash
cd tijara-app
```

3. Install the app dependencies:

```bash
flutter pub get
```

4. Set up Firebase for the app:

   - Create a new Firebase project in the [Firebase Console ↗](https://console.firebase.google.com/).
   - Enable Firebase Authentication and Firestore for your project.
   - Download the `google-services.json` file from the Firebase console.
   - Place the `google-services.json` file in the `android/app` directory.

1. Run the app:

```bash
flutter run
```

## Folder Structure

The project's folder structure is organized as follows:

```
├── lib
│   ├── models           # Data models
│   ├── providers        # State management with Provider
│   ├── screens          # App screens
│   ├── services         # Firebase and API services
│   ├── utils            # Utility functions and constants
│   └── main.dart        # App entry point
└── ...
```

## State Management

This app uses the Provider package for state management. The `providers` folder contains the different providers used throughout the app, such as `Auth.dart`, `Cart.dart`, and `Product.dart`. These providers manage the app's state and expose methods and properties that can be accessed by different widgets.

## Contributing

Contributions to this repository are welcome. If you find any issues or want to add new features, please follow these steps:

1. Fork the repository.
1. Create a new branch for your feature or bug fix.
1. Commit your changes and push them to your fork.
1. Submit a pull request describing your changes.

## License

This project is licensed under the [MIT license](LICENSE).

## Acknowledgments

- This app was developed using Flutter, an open-source UI software development kit created by Google.
- The Provider package was used for state management.
- Firebase was used for user authentication, database storage, and hosting.

## Contact

If you have any questions or suggestions, feel free to reach out to the project maintainers:

-Abdallah abdallhamohamed@gmail.com

We appreciate your interest in Tijara!

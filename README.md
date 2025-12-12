# AEROSAFE - Aviation Safety Reporting System

Une application mobile moderne de signalement de la sécurité aérienne basée sur Flutter, permettant le signalement anonyme des incidents, une communication sécurisée et une surveillance en temps réel via un tableau de bord pour les autorités aéronautiques.

## 📖 Project Description
AEROSAFE est une plateforme complète de signalement des incidents de sécurité aérienne conçue pour les autorités de l'aviation civile (comme l'ANAC au Togo) afin de collecter, gérer et analyser les incidents de sécurité. L'application propose les fonctionnalités suivantes :

- **Anonymous Chat System**: Canal de communication sécurisé et chiffré pour le signalement des incidents
- **QR Code Access**: Authentification rapide des agents par lecture de code QR
- **Admin Dashboard**: Surveillance en temps réel avec suivi des incidents, cartes thermiques et analyses
- **Multi-language Support**: Interface configurable pour les utilisateurs internationaux
- **Offline Capability**: Stockage local des données pour les rapports dans les zones à connectivité limitée

## 📋 Conditions préalables

Avant de configurer le projet, assurez-vous d'avoir installé les éléments suivants :

- **Flutter SDK**: ≥ 3.29.2 
- **Dart SDK**: ≥ 3.6.0
- **IDE**: Android Studio ou VS Code avec Flutter extensions
- **Mobile Development Tools**:
  - Android SDK (pour Android developpement)
- **Git**: pour control de version

## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/DevJB-cmd/AeroSafe
cd aerosafe
```

### 2. Installer les dépendances

```bash
flutter pub get
```

Cela installera tous les paquets requis, notamment :

- Frameworks d'interface utilisateur (sizer, flutter_svg, google_fonts)

- Réseau (dio, connectivity_plus)

- Visualisation des données (fl_chart, flutter_map)

- Sécurité (mobile_scanner pour les codes QR)

- Stockage (shared_preferences)


### 3. Platform-Specific Setup


####Configuration iOS (macOS uniquement)
1.Installer les dépendances CocoaPods :
```bash
cd ios
pod install
cd ..
```

2. ouvrir `ios/Runner.xcworkspace`dans Xcode et configurez la signature avec votre compte développeur Apple

### 5. Verifier Installation

```bash
flutter doctor -v
```

## 🚀 Running the Application

### Development Mode

Run on a connected device or emulator:

```bash
# demarrer sur l'appareil par defaut
flutter run



# Output location: build/app/outputs/flutter-apk/
```

#### iOS

```bash
# Build iOS release
flutter build ios --release

# Open in Xcode for signing and distribution
open ios/Runner.xcworkspace
```

## 📁 Structure du projet

```
aerosafe/
├── android/                   
├── ios/                        
├── lib/
│   ├── core/                   
│   │   └── app_export.dart     
│   ├── presentation/           
│   │   ├── anonymous_chat_screen/  
│   │   ├── qr_access_screen/       
│   │   ├── settings_screen/       
│   │   └── admin_dashboard_screen/ 
│   ├── routes/                
│   │   └── app_routes.dart     
│   ├── theme/                  
│   │   └── app_theme.dart      
│   ├── widgets/                
│   └── main.dart               
├── assets/                    
│   └── images/                
├── env.json                   
├── pubspec.yaml                
└── README.md                   
```



### 1. Système de chat anonyme

- Messagerie chiffrée de bout en bout
- Indicateurs de saisie et état de la connexion
- Interface de type terminal pour la création de rapports sécurisés
- Historique des messages horodatés

### 2. Authentification par code QR

- Connexion rapide des agents via la lecture d'un code QR
- Échange sécurisé d'identifiants

- Fonctionnement hors ligne pour les zones rurales

### 3. Tableau de bord d'administration
- Surveillance des incidents en temps réel

- Visualisation interactive sous forme de carte thermique

- Indicateurs et statistiques de santé
- Analyse hebdomadaire des tendances

### 4. Paramètres et personnalisation

- Prise en charge multilingue

- Changement de thème (clair/sombre)

- Préférences de sécurité

- Gestion des notifications

- Options d'accessibilité

## 🔐 Identifiants de connexion

Pour tester l'expérience utilisateur de l'application :


**Agent ID**: `ANAC-TG-2547`

(Utilisez cet identifiant pour générer un code QR ou pour vous connecter directement)


## 🧪 Testing

flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```


Avant le déploiement en production :

- [ ] Mettre à jour la version dans `pubspec.yaml`
- [ ] Définir les variables d'environnement de production dans `env.json`
- [ ] Tester sur des appareils physiques (Android et iOS)
- [ ] Exécuter la suite de tests complète : `flutter test`
- [ ] Générer les versions de publication
- [ ] Vérifier les certificats de signature de l'application
- [ ] Tester les fonctionnalités hors ligne
- [ ] Vérifier les configurations de sécurité
- [ ] Préparer les ressources pour l'App Store (captures d'écran, descriptions)


##  Connaissances
- Powered by [Flutter](https://flutter.dev) & [Dart](https://dart.dev)
- Styled with Material Design principles
- Map tiles from OpenStreetMap contributors

--

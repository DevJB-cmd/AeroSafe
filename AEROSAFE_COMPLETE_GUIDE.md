# 🛫 AEROSAFE - Application Complète

## Vue d'ensemble
**AEROSAFE** est une plateforme de signalement volontaire et anonyme pour l'aviation civile togolaise (ANAC Togo). L'application permet aux professionnels de l'aviation de signaler des incidents de sécurité de manière confidentielle, avec un système de chat sécurisé pour le suivi.

---

## 📱 Architecture de l'Application

### Structure des Dossiers
```
lib/
├── main.dart                          # Point d'entrée (initialisation + thème)
├── core/
│   ├── app_export.dart               # Exports centralisés
│   └── services/
│       └── anonymous_message_service.dart  # Gestion des messages anonymes
├── presentation/
│   ├── splash_screen/                # Écran de démarrage
│   ├── home_screen/                  # Page d'accueil intelligente
│   ├── incident_selection/           # Choix du type d'incident
│   ├── location_mapping/             # Sélection de la localisation
│   ├── description_input/            # Description détaillée du signalement
│   ├── anonymous_chat_screen/        # Chat anonyme sécurisé
│   ├── admin_authentication/         # Authentification admin (16 chiffres)
│   ├── admin_dashboard_screen/       # Tableau de bord administrateur
│   ├── qr_access_screen/             # Accès par code QR
│   └── settings_screen/              # Paramètres utilisateur
├── routes/
│   └── app_routes.dart               # Configuration des routes
├── theme/
│   └── app_theme.dart                # Thème global (bleu aviation + cyan)
└── widgets/
    ├── custom_app_bar.dart           # Barre d'application personnalisée
    ├── custom_bottom_bar.dart        # Barre de navigation inférieure
    └── [autres widgets réutilisables]
```

---

## 🔐 Sécurité

### Code d'Accès Admin
- **Format** : 16 chiffres (plus sécurisé)
- **Code valide** : `9209258291098652`
- **Interface** : Pinput avec masquage (●●●●)
- **Verrouillage** : 30 secondes après 3 tentatives échouées

### Anonymat Complet
- ✅ Pas de collecte de données personnelles
- ✅ Tokens cryptographiques pour suivi
- ✅ Messages chiffrés dans le chat
- ✅ Pas d'identification possible

---

## 📊 Flux de Navigation

### Flux 1 : Utilisateur Anonyme (Déclarant)
```
Splash Screen → Home Screen → Incident Selection
              → Location Mapping → Description Input
              → Confirmation (Token) → Anonymous Chat
```

### Flux 2 : Administrateur ANAC
```
Splash Screen → Home Screen → Admin Authentication (16 chiffres)
              → Admin Dashboard (voir tous les signalements)
              → Chat Admin avec Déclarants
```

### Flux 3 : Écrans Transversaux
- **Settings** : Langue (FR/EN/ES), Thème (Clair/Sombre), À propos
- **QR Access** : Accès alternatif par code QR

---

## 🎨 Thème et Design

### Couleurs Principales
- **Bleu Institutionnel** : `#0A1A3A` (ANAC, autorité)
- **Cyan Électrique** : `#00C6FF` (énergie, modernité)
- **Rouge Danger** : `#FF4757` (critiques)
- **Vert Succès** : `#00D95A` (confirmations)
- **Orange Avertissement** : `#FFB347` (alertes)

### Typographie
- **Titres** : Space Grotesk (technique aéronautique)
- **Corps** : Inter (lisibilité optimale)
- **Code/Tokens** : JetBrains Mono (tokens cryptographiques)

### Responsive Design
- ✅ Optimisé pour mobile (9:19.5 ratio iPhone moderne)
- ✅ Adaptation tablette
- ✅ Support des encoches (Dynamic Island)
- ✅ Touches tactiles renforcées

---

## 📋 Fonctionnalités Principales

### 1. Signalement d'Incident (Déclarant)
- ✅ 6 catégories d'incidents (Vol, Piste, Bagages, Comportement, Matériel, Autre)
- ✅ Localisation interactive sur plan d'aéroport
- ✅ Description avec limite de caractères (200 max)
- ✅ Barre d'émotions (😌😟😠😡😰)
- ✅ Dictée vocale (reconnaissance vocale)
- ✅ Ajout de photos
- ✅ Horodatage automatique

### 2. Chat Anonyme Sécurisé
- ✅ Messages avec horodatage
- ✅ Indicateur de connexion chiffrée
- ✅ Bouton "Message reçu" côté admin
- ✅ Statut d'affichage en temps réel
- ✅ Animations de frappe

### 3. Dashboard Administrateur
- ✅ Heatmap des incidents en direct
- ✅ Métriques de santé (% incidents, temps réponse)
- ✅ Feed des incidents en temps réel
- ✅ Section "Messages Anonymes Reçus"
- ✅ Compteur de non-lus
- ✅ Bouton "Marquer comme reçu"

### 4. Paramètres Utilisateur
- ✅ Sélection langue (FR/EN/ES)
- ✅ Sélection thème (Clair/Sombre/Système)
- ✅ Mode daltonien (si configuré)
- ✅ À propos de la plateforme

---

## 🚀 Démarrage de l'Application

### Prérequis
```bash
flutter --version          # v3.6.0 minimum
dart --version            # v3.6.0 minimum
```

### Installation
```bash
cd AeroSafe
flutter pub get
flutter pub get            # (redondant mais sûr)
```

### Lancer l'App

**Sur Web (Chrome) :**
```bash
flutter run -d chrome
```

**Sur Émulateur Android :**
```bash
flutter emulators --launch <emulator_id>
flutter run -d android
```

**Sur Simulateur iOS (macOS) :**
```bash
flutter run -d ios
```

**Mode Release (optimisé) :**
```bash
flutter run --release
```

---

## 🧪 Codes de Démonstration

### Admin - Authentification
- **PIN Admin (16 chiffres)** : `9209258291098652`
- **Tentatives échouées** : 3 avant verrouillage
- **Verrouillage** : 30 secondes

### Routes Disponibles
| Route | Écran |
|-------|-------|
| `/` | Splash Screen |
| `/home-screen` | Accueil |
| `/incident-selection` | Choix incident |
| `/location-mapping` | Localisation |
| `/description-input` | Description |
| `/anonymous-chat-screen` | Chat anonyme |
| `/admin-authentication` | Auth admin |
| `/admin-dashboard-screen` | Dashboard |
| `/qr-access-screen` | Accès QR |
| `/settings-screen` | Paramètres |

---

## 📦 Dépendances Clés

```yaml
sizer: ^2.0.15              # Design responsive
flutter_svg: ^2.0.9        # Support SVG
google_fonts: ^6.1.0       # Typographie
shared_preferences: ^2.2.2 # Stockage local
pinput: ^6.0.1             # Saisie PIN
local_auth: ^2.3.0         # Biométrie
google_maps_flutter: ^2.12.3 # Cartes
geolocator: ^13.0.4        # Géolocalisation
camera: ^0.10.5+5          # Caméra
record: ^6.0.0             # Enregistrement audio
```

---

## 🔧 Configuration Importante

### main.dart
- ✅ Orientation : Portrait uniquement
- ✅ ErrorWidget personnalisé
- ✅ TextScaler fixé à 1.0 (lisibilité)
- ✅ Thème par défaut : Clair

### app_export.dart
- ✅ Importe tous les services et thème
- ✅ Facilite l'accès aux ressources globales

### app_theme.dart
- ✅ Thème clair et sombre complets
- ✅ Palette aéronautique institutionnelle
- ✅ Styles Material Design 3

---

## 📱 Écrans Détails

### 1. Splash Screen
- Animation AEROSAFE avec logo ANAC
- Barre de progression
- Textes motivants
- Fond dégradé bleu nuit

### 2. Home Screen (Accueil)
- Bienvenue personnalisée
- 3 boutons d'action principaux
- Animations d'apparition séquentielle
- Bouton paramètres en haut à droite

### 3. Incident Selection
- Grille 3×2 avec 6 catégories
- Badges priorité (Critique, Élevée, etc.)
- Indicateurs d'incidents récents
- Progression visuelle (Étape 1/3)

### 4. Location Mapping
- Plan schématique d'aéroport
- Zones cliquables avec ripple effect
- Affichage zone sélectionnée
- Fréquence des incidents par zone

### 5. Description Input
- Champ texte 200 caractères max
- Compteur avec alerte (orange >180)
- Barre d'émotions (5 choix)
- Dictée vocale avec animation
- Horodatage corrigible

### 6. Anonymous Chat
- Messages avec horodatage
- Bulles différentes (déclarant vs agent)
- Bouton "Message reçu" pour agents
- Indicateur chiffrement
- Animation de frappe

### 7. Admin Dashboard
- 4 sections principales :
  1. Heatmap des incidents
  2. Graphique santé (jauges circulaires)
  3. Feed incidents temps réel
  4. Messages anonymes reçus

---

## 🐛 Dépannage

### Problème : "Code invalide" lors de connexion admin
**Solution** : Assurez-vous de taper exactement 16 chiffres : `9209258291098652`

### Problème : Les messages ne s'affichent pas
**Solution** : Le service `AnonymousMessageService` est global et persiste les messages. Vérifiez que vous naviguez correctement vers `/anonymous-chat-screen`.

### Problème : L'écran ne s'affiche pas
**Solution** : Vérifiez que la route est enregistrée dans `app_routes.dart` et que le WidgetBuilder est correct.

### Problème : Thème ne change pas
**Solution** : Les préférences sont sauvegardées dans SharedPreferences. Redémarrez l'app après changement.

---

## 🎯 Prochaines Étapes (Optionnel)

1. **Backend** : Connecter à Firebase/Supabase pour la persistance
2. **Analytics** : Ajouter Google Analytics pour le suivi
3. **Notifications** : Notifications push pour les admins
4. **Internationalisation** : Ajouter langues supplémentaires
5. **Biométrie** : Support empreinte digitale complet

---

## 📞 Support

**Contact ANAC Togo** : securite@anac.tg
**Version** : 2.0
**Date** : 15 Décembre 2025

---

✈️ **AEROSAFE - Pour une aviation plus sûre** ✈️

# 🏢 CSE SaaS Platform

> **Plateforme complète pour la gestion des Comités Sociaux et Économiques**

Une solution moderne et sécurisée pour gérer la location de matériel, les réservations, les utilisateurs et les statistiques de votre CSE.

## 🚀 Aperçu du projet

### Stack technique

- **Backend** : Node.js + Fastify + TypeScript + Sequelize + MySQL
- **Frontend** : React 19 + Vite + TypeScript + Tailwind CSS
- **Base de données** : MySQL avec Sequelize ORM
- **Authentification** : JWT + 2FA (TOTP + WebAuthn)
- **Architecture** : Monorepo avec separation backend/frontend

### Fonctionnalités principales

#### 🔐 Authentification & Sécurité
- Inscription publique avec validation admin
- Connexion sécurisée (JWT + cookies HTTP-only)
- Double authentification (TOTP + Passkeys WebAuthn)
- Réinitialisation de mot de passe par email
- Gestion des sessions et déconnexion automatique

#### 👥 Gestion des utilisateurs
- CRUD complet avec rôles et permissions
- Gestion des crédits et soldes
- Suivi et validation des cautions
- Historique des actions utilisateur

#### 📦 Catalogue produits
- Interface de gestion complète
- Upload multiple (images, PDF, vidéos)
- Organisation par sections et sous-sections
- Attributs dynamiques personnalisables

#### 📅 Système de réservation
- Calendrier interactif de disponibilité
- Règles configurables par section
- Vérification automatique des crédits
- Codes de réservation uniques

#### 📊 Dashboard & Analytics
- Widgets modulaires configurables
- Statistiques en temps réel
- Export CSV/Excel
- Filtres avancés

## 🏗️ Architecture

```
thales/
├── backend/                 # API Node.js + Fastify
│   ├── src/
│   │   ├── index.ts        # Point d'entrée
│   │   ├── models/         # Modèles Sequelize
│   │   ├── routes/         # Routes API
│   │   ├── services/       # Logique métier
│   │   ├── middleware/     # Middlewares
│   │   └── utils/          # Utilitaires
│   ├── package.json
│   └── tsconfig.json
├── frontend/               # Application React
│   ├── src/
│   │   ├── components/     # Composants React
│   │   ├── pages/          # Pages de l'app
│   │   ├── hooks/          # Hooks personnalisés
│   │   ├── services/       # Services API
│   │   └── utils/          # Utilitaires
│   ├── package.json
│   └── vite.config.ts
└── .github/
    └── copilot-instructions.md
```

## 🛠️ Installation

### Prérequis

- Node.js 18+ et npm
- MySQL 8.0+
- Git

### Configuration

1. **Cloner et installer les dépendances**
```bash
git clone <repo-url>
cd thales

# Backend
cd backend
npm install
cp .env.example .env

# Frontend  
cd ../frontend
npm install
```

2. **Configuration de la base de données**
```bash
# Créer la base de données MySQL
mysql -u root -p
CREATE DATABASE cse_saas;
```

3. **Variables d'environnement**

Éditer `backend/.env` :
```env
NODE_ENV=development
PORT=3000
DATABASE_URL=mysql://root:password@localhost:3306/cse_saas
JWT_SECRET=your-super-secret-jwt-key
FRONTEND_URL=http://localhost:5173
SMTP_HOST=smtp.gmail.com
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
```

## 🚀 Développement

### Démarrage des serveurs

```bash
# Terminal 1 - Backend (port 3000)
cd backend
npm run dev

# Terminal 2 - Frontend (port 5173)  
cd frontend
npm run dev
```

### URLs de développement

- **Frontend** : http://localhost:5173
- **API Backend** : http://localhost:3000/api
- **Health Check** : http://localhost:3000/api/health

### Scripts disponibles

#### Backend
```bash
npm run dev        # Développement avec nodemon
npm run build      # Build TypeScript
npm run start      # Production
```

#### Frontend
```bash
npm run dev        # Serveur de développement Vite
npm run build      # Build de production
npm run preview    # Preview du build
```

## 🗄️ Modèles de données

### Utilisateurs
```typescript
User {
  id: number
  email: string
  firstName: string
  lastName: string
  status: 'pending' | 'active' | 'suspended'
  role: string
  credits: number
  cautionStatus: 'pending' | 'validated' | 'exempted'
  // + champs d'authentification et audit
}
```

### Produits
```typescript
Product {
  id: number
  name: string
  description: text
  price: decimal
  minDuration: number
  status: 'available' | 'maintenance' | 'retired'
  sectionId: number
  attributes: JSON
  images: string[]
  files: string[]
}
```

### Réservations
```typescript
Reservation {
  id: number
  userId: number
  productId: number
  startDate: date
  endDate: date
  status: 'pending' | 'confirmed' | 'cancelled'
  reservationCode: string
  totalPrice: decimal
}
```

## 🔧 Configuration avancée

### Variables d'environnement complètes

```env
# Serveur
NODE_ENV=development|production
PORT=3000
HOST=localhost

# Base de données
DATABASE_URL=mysql://user:pass@host:port/dbname
DB_HOST=localhost
DB_PORT=3306
DB_NAME=cse_saas
DB_USER=root
DB_PASSWORD=password

# Sécurité
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=24h
COOKIE_SECRET=cookie-secret

# Email
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=email@domain.com
SMTP_PASS=app-password

# Upload
UPLOAD_MAX_SIZE=10485760
UPLOAD_DIR=./uploads

# Rate limiting
RATE_LIMIT_MAX=100
RATE_LIMIT_WINDOW_MS=900000
```

## 📝 Standards de développement

### Code Style
- **TypeScript strict** partout
- **ESLint + Prettier** pour la cohérence
- **Conventions de nommage** : camelCase, PascalCase pour composants
- **Imports relatifs** avec chemins absolus configurés

### Sécurité
- Validation stricte des entrées (Zod frontend, Joi backend)
- Échappement des données utilisateur
- Helmet.js pour headers sécurisés
- Rate limiting sur toutes les routes

### Performance
- Pagination systématique
- Cache avec React Query
- Lazy loading des composants
- Images optimisées

## 🎯 Roadmap

### Phase 1 (MVP) ✅
- [x] Setup architecture backend/frontend
- [x] Configuration TypeScript + Tailwind
- [x] Instructions GitHub Copilot

### Phase 2 (Core Features)
- [ ] Authentification complète (JWT + 2FA)
- [ ] CRUD Utilisateurs avec rôles
- [ ] CRUD Produits avec uploads
- [ ] Système de réservation

### Phase 3 (Advanced)
- [ ] Dashboard avec widgets
- [ ] Notifications multi-canal
- [ ] Import/Export données
- [ ] PWA + mode offline

### Phase 4 (Enterprise)
- [ ] Multi-tenant
- [ ] API publique
- [ ] Intégrations tierces
- [ ] Analytics avancées

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/amazing-feature`)
3. Commit les changements (`git commit -m 'Add amazing feature'`)
4. Push vers la branche (`git push origin feature/amazing-feature`)
5. Ouvrir une Pull Request

## 📄 Licence

Ce projet est sous licence ISC. Voir le fichier `LICENSE` pour plus de détails.

## 📞 Support

- **Documentation** : Voir `/docs` (à venir)
- **Issues** : GitHub Issues
- **Email** : support@cse-saas.com

---

**Fait avec ❤️ pour les CSE par l'équipe Thales**

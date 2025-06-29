#!/bin/bash

# Script pour créer toutes les issues GitHub basées sur le CDC
# Auteur: AI Assistant
# Date: 2025-06-29

echo "🚀 Création des issues GitHub pour le projet CSE SaaS"
echo "=================================================="

# Fonction pour créer une issue
create_issue() {
    local title="$1"
    local body="$2"
    local labels="$3"
    local milestone="$4"
    
    echo "Création de l'issue: $title"
    gh issue create \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --milestone "$milestone"
}

# V1.0 - Foundation (Critiques et Hautes priorités)

echo ""
echo "📚 V1.0 - Foundation Issues"
echo "==========================="

# 1. Authentification & sécurité (CRITIQUE)
create_issue "🔐 Authentification & sécurité robuste" "
## 🎯 **Objectif utilisateur**
Permettre aux utilisateurs de s'authentifier de façon robuste, valider leur inscription et protéger leur compte.

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Système d'authentification**
  - [ ] Modèle User avec statuts (pending, active, suspended, disabled)
  - [ ] JWT tokens avec refresh tokens
  - [ ] Cookies HTTP-only sécurisés
  - [ ] Hash bcrypt pour mots de passe
- [ ] **Backend: Inscription et validation**
  - [ ] Route inscription publique → statut pending
  - [ ] Interface admin pour validation manuelle
  - [ ] Email de confirmation
- [ ] **Backend: Réinitialisation mot de passe**
  - [ ] Token unique à usage unique
  - [ ] Email sécurisé avec lien expirant
- [ ] **Backend: 2FA et Passkeys**
  - [ ] TOTP avec QR code
  - [ ] WebAuthn pour Passkeys
  - [ ] Middleware de vérification 2FA
- [ ] **Backend: Sécurité avancée**
  - [ ] Politique mot de passe configurable
  - [ ] Rate limiting sur login
  - [ ] Journal RGPD (date, version)
  - [ ] Mise en sommeil automatique (cron)
- [ ] **Frontend: Interfaces utilisateur**
  - [ ] Formulaires login/signup responsive
  - [ ] Page activation 2FA avec QR code
  - [ ] Interface réinitialisation mot de passe
  - [ ] Feedback temps réel (validation, erreurs)
- [ ] **Tests: Couverture complète**
  - [ ] Tests unitaires auth service
  - [ ] Tests d'intégration API auth
  - [ ] Tests E2E parcours complet
  - [ ] Tests sécurité (tentatives brute force)

## ✅ **Critères d'acceptation**
- [ ] Inscription crée un compte pending
- [ ] Connexion autorisée seulement si status = active
- [ ] 2FA demandée lorsque activée ou requise par rôle
- [ ] Réinitialisation mot de passe fonctionnelle et sécurisée
- [ ] Comptes inactifs désactivés automatiquement
- [ ] Consentement RGPD enregistré

## 👥 **Personas concernés**
- [x] Utilisateur
- [x] Admin

## 🧪 **Cas d'utilisation**
- Inscription → validation → connexion
- Connexion avec Passkey
- Échec 2FA : message d'erreur clair
- Réinitialisation mot de passe oublié

## 🎨 **UX/UI**
- Formulaires mobiles, feedback immédiat
- QR-code pour TOTP, prompt Passkey natif
- Toasts succès/erreur
- Interface de validation admin claire

## 📈 **Complexité & Priorité**
- **Complexité**: Très élevée
- **Priorité**: Critique

## 🔗 **Dépendances**
- Base pour toutes les autres fonctionnalités

## 📋 **Sous-issues techniques**
- [ ] #TBD - Base de données et modèles User
- [ ] #TBD - API endpoints authentification  
- [ ] #TBD - Middleware sécurité et permissions
- [ ] #TBD - Interface administrateur validation comptes
- [ ] #TBD - Frontend composants authentification
- [ ] #TBD - Tests sécurité et performance
" "priority:critical,complexity:very-high,area:auth,area:backend,area:frontend,area:database" "🏗️ V1.0 - Foundation"

# 2. Gestion des utilisateurs (HAUTE)
create_issue "👤 Gestion complète des utilisateurs" "
## 🎯 **Objectif utilisateur**
Gérer son profil, et pour les admins, gérer tous les comptes (rôles, statuts, crédits, cautions…).

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Modèle User étendu**
  - [ ] Champs: nom, email, téléphone, adresse
  - [ ] Solde crédits et statut caution
  - [ ] Gestion des rôles et permissions
  - [ ] Historique des connexions
- [ ] **Backend: CRUD complet**
  - [ ] API endpoints RESTful
  - [ ] Validation des données
  - [ ] Middleware permissions
  - [ ] Logging des actions
- [ ] **Frontend: Interface utilisateur**
  - [ ] Page profil utilisateur
  - [ ] Modification informations personnelles
  - [ ] Consultation historique personnel
- [ ] **Frontend: Interface admin**
  - [ ] Tableau de bord utilisateurs
  - [ ] Recherche et filtres avancés
  - [ ] Modals d'édition inline
  - [ ] Gestion crédits et cautions
- [ ] **Tests: Validation fonctionnelle**
  - [ ] Tests CRUD utilisateurs
  - [ ] Tests permissions et sécurité
  - [ ] Tests interface et UX

## ✅ **Critères d'acceptation**
- [ ] Utilisateur modifie son profil
- [ ] Admin crée, désactive ou supprime un compte
- [ ] Crédits et cautions visibles et éditables
- [ ] Historique consultable
- [ ] Recherche et filtres fonctionnels

## 👥 **Personas concernés**
- [x] Utilisateur
- [x] Admin

## 🧪 **Cas d'utilisation**
- Mise à jour de l'adresse email perso
- Admin recharge le crédit d'un collaborateur
- Suspension d'un compte non conforme
- Consultation de l'historique personnel

## 🎨 **UX/UI**
- Tableau paginé avec recherche et filtres
- Modals d'édition inline
- Badges de statut et jauge de crédit
- Interface responsive et intuitive

## 📈 **Complexité & Priorité**
- **Complexité**: Moyenne
- **Priorité**: Haute

## 🔗 **Dépendances**
- Dépend de: #1 (Authentification)

## 📋 **Sous-issues techniques**
- [ ] #TBD - Extension du modèle User
- [ ] #TBD - API CRUD utilisateurs
- [ ] #TBD - Interface profil utilisateur
- [ ] #TBD - Dashboard admin utilisateurs
- [ ] #TBD - Tests gestion utilisateurs
" "priority:high,complexity:medium,area:backend,area:frontend,area:database" "🏗️ V1.0 - Foundation"

echo "Pause de 2 secondes entre les créations..."
sleep 2

# 3. Gestion des produits (HAUTE)
create_issue "📦 Gestion complète des produits" "
## 🎯 **Objectif utilisateur**
Créer et consulter des fiches produits riches (images, PDF, vidéos).

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Modèle Product**
  - [ ] Champs: nom, description, prix, durée min/max
  - [ ] Statuts: disponible, maintenance, archivé
  - [ ] Liaison avec sections/sous-sections
  - [ ] Attributs dynamiques clé:valeur
- [ ] **Backend: Gestion fichiers**
  - [ ] Upload multi-fichiers (images, PDF, vidéos)
  - [ ] Stockage local /uploads/products/{id}
  - [ ] Validation types et tailles
  - [ ] API téléchargement sécurisé
- [ ] **Frontend: Interface produits**
  - [ ] Liste produits avec filtres
  - [ ] Fiche produit détaillée avec onglets
  - [ ] Galerie images avec zoom
  - [ ] Lecteur vidéo intégré
- [ ] **Frontend: Gestion admin**
  - [ ] CRUD produits complet
  - [ ] Upload drag-and-drop
  - [ ] Prévisualisation instantanée
  - [ ] Gestion des attributs dynamiques
- [ ] **Tests: Validation complète**
  - [ ] Tests CRUD produits
  - [ ] Tests upload et stockage
  - [ ] Tests interface utilisateur

## ✅ **Critères d'acceptation**
- [ ] Au moins une image obligatoire à la création
- [ ] Fichiers listés et téléchargeables
- [ ] Filtrage par statut et section opérationnel
- [ ] Upload drag-and-drop fonctionnel
- [ ] Prévisualisation immédiate

## 👥 **Personas concernés**
- [x] Admin / Gestionnaire
- [x] Utilisateur

## 🧪 **Cas d'utilisation**
- Publication d'un reflex avec 3 photos + notice PDF
- Ajout tardif d'une vidéo tuto
- Rejet d'un fichier > 100 Mo
- Consultation fiche produit avant réservation

## 🎨 **UX/UI**
- Zone drag-and-drop, miniatures instantanées
- Fiche produit en onglets : Info | Fichiers | Historique
- Étiquette statut (« Disponible », « Archivé »)
- Galerie responsive avec lightbox

## 📈 **Complexité & Priorité**
- **Complexité**: Élevée
- **Priorité**: Haute

## 🔗 **Dépendances**
- Dépend de: #1 (Authentification)
- Lié à: #13 (Sections/Sous-sections)

## 📋 **Sous-issues techniques**
- [ ] #TBD - Modèle Product et relations
- [ ] #TBD - API gestion fichiers
- [ ] #TBD - Interface liste et fiche produits
- [ ] #TBD - Upload et gestion médias
- [ ] #TBD - Tests produits et fichiers
" "priority:high,complexity:high,area:backend,area:frontend" "🏗️ V1.0 - Foundation"

sleep 2

# 4. Réservation & calendrier (CRITIQUE)
create_issue "📅 Système de réservation et calendrier" "
## 🎯 **Objectif utilisateur**
Réserver un produit via un calendrier clair, dans le respect des règles CSE.

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Modèle Reservation**
  - [ ] Champs: dates, code unique, statut, utilisateur, produit
  - [ ] Statuts: pending, confirmed, active, completed, cancelled
  - [ ] Génération automatique de code unique
  - [ ] Relations avec User et Product
- [ ] **Backend: Règles métier**
  - [ ] Jours d'entrée/sortie configurables par section
  - [ ] Vérification solde et caution avant validation
  - [ ] Blocage jours fériés et weekends
  - [ ] Durées min/max par produit
  - [ ] Détection conflits de réservation
- [ ] **Backend: Calendrier et disponibilités**
  - [ ] API disponibilités en temps réel
  - [ ] Calcul des créneaux libres
  - [ ] Gestion des exceptions et blocages
- [ ] **Frontend: Interface calendrier**
  - [ ] Calendrier interactif (FullCalendar ou similaire)
  - [ ] Affichage disponibilités temps réel
  - [ ] Sélection période intuitive
  - [ ] Couleurs dispo/indispo distinctes
- [ ] **Frontend: Processus réservation**
  - [ ] Formulaire réservation étapes
  - [ ] Résumé avant validation
  - [ ] Confirmation et code unique
  - [ ] Page 'Mes réservations'
- [ ] **Tests: Validation business logic**
  - [ ] Tests règles métier
  - [ ] Tests conflits réservations
  - [ ] Tests interface calendrier
  - [ ] Tests performance

## ✅ **Critères d'acceptation**
- [ ] Calendrier affiche disponibilités en temps réel
- [ ] Message d'erreur si règle violée
- [ ] Code unique généré automatiquement
- [ ] Historique visible par utilisateur
- [ ] Blocage si caution non validée
- [ ] Notifications envoyées

## 👥 **Personas concernés**
- [x] Utilisateur
- [x] Admin

## 🧪 **Cas d'utilisation**
- Réservation jeudi→lundi, validation auto
- Blocage si caution non validée
- Prolongation si créneau libre
- Annulation avec remboursement crédits

## 🎨 **UX/UI**
- Couleurs dispo/indispo distinctes
- Résumé avant validation
- Statut en temps réel dans « Mes réservations »
- Interface mobile optimisée

## 📈 **Complexité & Priorité**
- **Complexité**: Très élevée
- **Priorité**: Critique

## 🔗 **Dépendances**
- Dépend de: #1 (Authentification), #2 (Utilisateurs), #3 (Produits)
- Requis pour: #5 (Mouvements)

## 📋 **Sous-issues techniques**
- [ ] #TBD - Modèle Reservation et règles métier
- [ ] #TBD - API calendrier et disponibilités
- [ ] #TBD - Interface calendrier interactif
- [ ] #TBD - Processus réservation frontend
- [ ] #TBD - Tests réservations et calendrier
" "priority:critical,complexity:very-high,area:backend,area:frontend" "🏗️ V1.0 - Foundation"

sleep 2

# 13. Hiérarchie Sections/Sous-sections (HAUTE)
create_issue "🧩 Hiérarchie Sections et Sous-sections" "
## 🎯 **Objectif utilisateur**
Structurer le catalogue via Sections et Sous-Sections uniquement.

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Modèles Section/SubSection**
  - [ ] Table Section (nom, description, ordre, config)
  - [ ] Table SubSection (nom, sectionId, ordre)
  - [ ] Jours autorisés configurables par section
  - [ ] CRUD complet avec validation
- [ ] **Backend: Relations et contraintes**
  - [ ] Liaison Product → SubSection → Section
  - [ ] Liaison User → Section (permissions)
  - [ ] Contraintes d'intégrité référentielle
- [ ] **Frontend: Interface hiérarchique**
  - [ ] Arborescence collapsible
  - [ ] Drag & drop pour réorganiser
  - [ ] Dropdown section + recherche
  - [ ] Badge couleur par section
- [ ] **Frontend: Gestion admin**
  - [ ] CRUD sections/sous-sections
  - [ ] Configuration jours par section
  - [ ] Assignment produits et utilisateurs
- [ ] **Tests: Structure hiérarchique**
  - [ ] Tests relations et contraintes
  - [ ] Tests permissions par section
  - [ ] Tests interface arborescence

## ✅ **Critères d'acceptation**
- [ ] Sections créables, éditables, supprimables
- [ ] Produits correctement rattachés / filtrés
- [ ] Jours de location appliqués par section
- [ ] Arborescence intuitive et responsive

## 👥 **Personas concernés**
- [x] Admin
- [x] Utilisateur

## 🧪 **Cas d'utilisation**
- Création section « Photo » → sous-section « Reflex »
- Filtrer la liste par sous-section
- Configuration jours spécifiques par section

## 🎨 **UX/UI**
- Arborescence collapsible
- Dropdown section + recherche
- Badge couleur par section
- Interface d'administration claire

## 📈 **Complexité & Priorité**
- **Complexité**: Moyenne
- **Priorité**: Haute

## 🔗 **Dépendances**
- Dépend de: #1 (Authentification)
- Requis par: #3 (Produits), #4 (Réservations)

## 📋 **Sous-issues techniques**
- [ ] #TBD - Modèles Section/SubSection
- [ ] #TBD - API hiérarchie et relations
- [ ] #TBD - Interface arborescence
- [ ] #TBD - Configuration par section
- [ ] #TBD - Tests hiérarchie
" "priority:high,complexity:medium,area:backend,area:frontend,area:database" "🏗️ V1.0 - Foundation"

echo ""
echo "✅ Issues V1.0 créées avec succès!"
echo "🚀 Continuez avec V2.0 en relançant le script..."
echo ""
echo "📊 Résumé V1.0:"
echo "- 5 issues critiques/hautes créées"
echo "- Foundation solide pour le développement"
echo "- Prêt pour commencer le développement!"

" "enhancement,needs-setup" 1

# Créons maintenant les issues V2.0 et V3.0 en lot
sleep 2

echo ""
echo "📚 Création des issues V2.0 - Core Features"
echo "=========================================="

# Issues V2.0 importantes
create_issue "🔁 Système de mouvements (Entrée/Sortie)" "
## 🎯 **Objectif utilisateur**
Tracer la sortie et le retour des produits avec dates réelles et justificatifs.

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Modèle Movement**
  - [ ] Types: checkout, return
  - [ ] États produit et fichiers justificatifs
  - [ ] Calcul automatique retards
  - [ ] Permissions spéciales bypass
- [ ] **Frontend: Interface mouvements**
  - [ ] Formulaires sortie/retour
  - [ ] Upload photos justificatives
  - [ ] Timeline des mouvements
- [ ] **Tests: Validation mouvements**

## ✅ **Critères d'acceptation**
- [ ] Date réelle enregistrée + état produit
- [ ] Blocage hors jours autorisés sans permission
- [ ] Historique complet consultable

## 📈 **Complexité & Priorité**
- **Complexité**: Moyenne
- **Priorité**: Haute

## 🔗 **Dépendances**
- Dépend de: #4 (Réservations)
" "priority:high,complexity:medium,area:backend,area:frontend" "🚀 V2.0 - Core Features"

sleep 1

create_issue "🔔 Système de notifications complet" "
## 🎯 **Objectif utilisateur**
Être informé en temps réel des événements clés.

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Service notifications**
  - [ ] Table Notification
  - [ ] Canaux: email, in-app, push
  - [ ] Templates dynamiques
  - [ ] Queue système
- [ ] **Frontend: Centre notifications**
  - [ ] Icône cloche + compteur
  - [ ] Panneau slide-in
  - [ ] Notifications temps réel
- [ ] **Tests: Notifications**

## ✅ **Critères d'acceptation**
- [ ] Notification créée à chaque événement
- [ ] Badge non lus mis à jour
- [ ] Logs d'envoi

## 📈 **Complexité & Priorité**
- **Complexité**: Moyenne
- **Priorité**: Haute
" "priority:high,complexity:medium,area:backend,area:frontend" "🚀 V2.0 - Core Features"

sleep 1

create_issue "⚙️ Configuration avancée du système" "
## 🎯 **Objectif utilisateur**
Personnaliser les règles globales ou par section.

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: Système config**
  - [ ] Table Config dynamique
  - [ ] Scope tenant/section
  - [ ] Validation types
  - [ ] Cache config
- [ ] **Frontend: Interface admin**
  - [ ] Onglets par catégorie
  - [ ] Formulaires dynamiques
  - [ ] Feedback temps réel
- [ ] **Tests: Configuration**

## ✅ **Critères d'acceptation**
- [ ] Paramètres modifiables via UI
- [ ] Isolation par tenant/section
- [ ] Changements appliqués instantanément

## 📈 **Complexité & Priorité**
- **Complexité**: Moyenne
- **Priorité**: Haute
" "priority:high,complexity:medium,area:backend,area:frontend" "🚀 V2.0 - Core Features"

echo ""
echo "📚 Création des issues V3.0 - Advanced Features"
echo "==============================================="

sleep 1

create_issue "📲 Progressive Web App (PWA)" "
## 🎯 **Objectif utilisateur**
Installer et utiliser le site comme une application mobile native.

## 🔧 **Sous-tâches techniques**
- [ ] **Frontend: Configuration PWA**
  - [ ] Manifest.json
  - [ ] Service Worker
  - [ ] Cache strategies
  - [ ] Offline support
- [ ] **Tests: PWA**

## ✅ **Critères d'acceptation**
- [ ] Installable depuis navigateurs
- [ ] Icône & splash screen corrects
- [ ] Navigation offline partielle

## 📈 **Complexité & Priorité**
- **Complexité**: Moyenne
- **Priorité**: Moyenne
" "priority:medium,complexity:medium,area:frontend" "⭐ V3.0 - Advanced"

sleep 1

create_issue "💬 Messagerie interne temps réel" "
## 🎯 **Objectif utilisateur**
Chat en temps réel entre utilisateurs et admins.

## 🔧 **Sous-tâches techniques**
- [ ] **Backend: WebSocket + DB**
  - [ ] Socket.io
  - [ ] Tables Thread, Message
  - [ ] Multi-admin support
  - [ ] Pièces jointes
- [ ] **Frontend: Interface chat**
  - [ ] Chat temps réel
  - [ ] Liste des conversations
  - [ ] Notifications push
- [ ] **Tests: Messagerie**

## ✅ **Critères d'acceptation**
- [ ] Scan temps réel, notifications
- [ ] Attachments consultables
- [ ] Historique non éditable

## 📈 **Complexité & Priorité**
- **Complexité**: Très élevée
- **Priorité**: Critique
" "priority:critical,complexity:very-high,area:backend,area:frontend" "⭐ V3.0 - Advanced"

echo ""
echo "🎉 Création des issues GitHub terminée!"
echo "======================================"
echo ""
echo "📊 **Résumé total:**"
echo "- ✅ Templates GitHub créés"
echo "- ✅ Labels et milestones configurés"  
echo "- ✅ 10+ issues principales créées"
echo "- ✅ Roadmap V1.0 → V2.0 → V3.0 définie"
echo ""
echo "🚀 **Prochaines étapes:**"
echo "1. Aller sur GitHub pour voir les issues"
echo "2. Créer un Project Board"
echo "3. Commencer par les issues V1.0"
echo "4. Respecter l'ordre: Auth → Users → Products → Reservations"
echo ""
echo "🔗 **Liens rapides:**"
echo "- Issues: https://github.com/Nistro-dev/cse-saas/issues"
echo "- Milestones: https://github.com/Nistro-dev/cse-saas/milestones"
echo "- Labels: https://github.com/Nistro-dev/cse-saas/labels"

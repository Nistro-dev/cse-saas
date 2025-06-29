# 📦 Fonctionnalités détaillées – CSE SaaS

## 🔐 1. Authentification & sécurité
🎯 Objectif utilisateur  
Permettre à l’utilisateur de s’authentifier de manière sécurisée, valider son inscription et protéger son compte.

🧩 Sous-tâches techniques  
- Connexion sécurisée par session (cookie HTTP-only)  
- Inscription publique (`pending`) et validation manuelle (`APPROVE_USER_REGISTRATION`)  
- Politique de mot de passe configurable (longueur, complexité)  
- Réinitialisation de mot de passe via email (tokens sécurisés)  
- 2FA : TOTP (speakeasy) **et** Passkeys (WebAuthn/FIDO2)  
- Mise en sommeil automatique des comptes inactifs (cron)  
- Stockage du consentement RGPD (date, version)

✅ Critères d’acceptation  
- Inscription crée un compte `pending`  
- L’admin peut approuver/refuser  
- Connexion autorisée si `status = active`  
- Réinitialisation de mot de passe opérationnelle  
- 2FA activable et exigé à la connexion  
- Comptes inactifs désactivés automatiquement  
- CGU/RGPD validés à l’inscription

📈 Complexité & priorité  
- Complexité : **Élevée**  
- Priorité : **Critique**

👥 Personas concernés  
- **Utilisateur**  
- **Admin**

🧪 Cas d’utilisation  
- Normal : inscription → validation → connexion  
- Alternatif : connexion avec TOTP ou passkey  
- Exceptionnel : mauvais mot de passe ou code 2FA invalide → message d’erreur

🎨 UX/UI  
- Formulaires responsives, feedback immédiat  
- QR Code / passkey prompt clair  
- Toasts pour erreurs et succès  

---

## 👤 2. Gestion des utilisateurs
🎯 Objectif utilisateur  
Gérer son profil et, pour les admins, gérer l’ensemble des comptes (rôles, statuts, cautions, crédits…).

🧩 Sous-tâches techniques  
- CRUD complet (`User` model)  
- Attributs : nom, prénom, email pro/perso, téléphone  
- Statuts : `pending`, `active`, `suspended`, etc.  
- Gestion du crédit (solde, recharges, débits)  
- Suivi et validation de la caution (`cautionStatus`)  
- Attribution dynamique de rôles & permissions  
- Historique des actions (login, modif. profil…)

✅ Critères d’acceptation  
- L’utilisateur peut modifier son propre profil  
- L’admin peut créer, modifier, désactiver, supprimer  
- Crédits et cautions gérés et visibles  
- Historique consultable

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Haute**

👥 Personas concernés  
- **Utilisateur**  
- **Admin**

🧪 Cas d’utilisation  
- Mise à jour de coordonnées personnelles  
- Attribution d’un rôle par un admin  
- Recharge manuelle de crédit

🎨 UX/UI  
- Tableau paginé avec filtres et recherche  
- Modals d’édition inline  
- Badges de statut et indicateurs de crédit  

---

## 📦 3. Gestion des produits
🎯 Objectif utilisateur  
Créer et consulter des fiches produits riches (images, PDF, vidéos, fichiers) pour la location.

🧩 Sous-tâches techniques  
- CRUD `Product` model  
- Champs : nom, description, prix, durée min., statut  
- Attributs dynamiques (clé → valeur)  
- Uploads multiples (images, PDF, vidéos, autres fichiers)  
- Hébergement local des fichiers  
- Liaison à `Section` / `SubSection`  

✅ Critères d’acceptation  
- Ajout d’au moins une image obligatoire  
- Possibilité d’uploader PDF, vidéos et fichiers annexes  
- Tous les fichiers sont listés et consultables  
- Filtrage par statut et section opérationnel

📈 Complexité & priorité  
- Complexité : **Moyenne à élevée**  
- Priorité : **Haute**

👥 Personas concernés  
- **Admin / Gestionnaire**  
- **Utilisateur**

🧪 Cas d’utilisation  
- Publication d’un produit avec 3 images + 1 PDF  
- Ajout tardif d’un manuel technique PDF  
- Rejet d’un fichier trop volumineux

🎨 UX/UI  
- Interface drag & drop pour upload  
- Preview instantanée (miniatures, icônes…)  
- Fiche produit structurée (onglets ou sections)

---

## 📅 4. Réservation & calendrier
🎯 Objectif utilisateur  
Réserver un produit via un calendrier clair, en respectant jours et règles CSE.

🧩 Sous-tâches techniques  
- Calendrier cliquable de disponibilité  
- Jours d’entrée/sortie config. **par section**  
- Vérification solde de crédits & `cautionStatus`  
- Blocage jours fériés et périodes fermées  
- Durée min. et max. (p.ex. 3 semaines)  
- Génération de code unique (`reservationCode`)  
- Statuts : `pending`, `confirmed`, `cancelled`  
- Historique des réservations

✅ Critères d’acceptation  
- Affichage visuel des plages disponibles  
- Erreur claire si règle non respectée  
- Notification création & confirmation  
- Code unique généré systématiquement

📈 Complexité & priorité  
- Complexité : **Élevée**  
- Priorité : **Critique**

👥 Personas concernés  
- **Utilisateur**  
- **Admin**

🧪 Cas d’utilisation  
- Réservation du jeudi au lundi, validée auto  
- Prolongation demandée si dispo  
- Blocage si caution non validée

🎨 UX/UI  
- Couleurs distinctes pour dispo/indispo  
- Résumé dynamique avant validation  
- Indicateur de statut en temps réel

---

## 🔁 5. Mouvements (Entrée / Sortie)
🎯 Objectif utilisateur  
Suivre la sortie et le retour des produits, avec dates réelles et justificatifs, même hors jours autorisés sous permission.

🧩 Sous-tâches techniques  
- Création de mouvement `checkout` et `return`  
- Stockage : date effective, état (neuf/usé/endommagé), justificatifs  
- Permissions : `BYPASS_CHECKOUT_DAY`, `BYPASS_RETURN_DAY`  
- Calcul et affichage de retard si retour tardif  
- Historique des mouvements par produit et utilisateur

✅ Critères d’acceptation  
- Chaque mouvement stocke date réelle  
- Blocage hors jours sans permission  
- Fichiers attachés visibles  
- Historique complet et consultable

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Haute**

👥 Personas concernés  
- **Gestionnaire**  
- **Admin**

🧪 Cas d’utilisation  
- Sortie jeudi, retour lundi  
- Retour le mercredi via permission  
- Blocage si pas de permission

🎨 UX/UI  
- Formulaire avec calendrier & champs état  
- Indication prévue vs réelle  
- Badges pour mouvements dérogatoires

---

## 🧰 6. Maintenance
🎯 Objectif utilisateur  
Planifier et documenter les maintenances produits pour maximaliser la fiabilité.

🧩 Sous-tâches techniques  
- CRUD `Maintenance` model  
- Fréquences : ponctuelle, hebdo, mensuelle, annuelle  
- Blocage produit durant intervention  
- Historique des interventions (description + date)  
- Notifications utilisateurs impactés

✅ Critères d’acceptation  
- Blocage auto sur période planifiée  
- Respect des fréquences récurrentes  
- Historique visible & exportable  
- Notification avant intervention

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Moyenne**

👥 Personas concernés  
- **Gestionnaire**  
- **Admin**

🧪 Cas d’utilisation  
- Intervention annuelle automatisée  
- Maintenance urgente placée manuellement  
- Conflit réservation/maintenance → alerte

🎨 UX/UI  
- Planning visuel global  
- Formulaire simple avec calendrier  
- Alertes claires sur conflit

---

## 📥 7. Notifications
🎯 Objectif utilisateur  
Informer les utilisateurs en temps réel (email, in-app et push) des événements clés.

🧩 Sous-tâches techniques  
- Déclencheurs : réservation, retour tardif, maintenance, caution  
- Canaux :  
  - Email SMTP  
  - In-app (table `Notification`, statut `read/unread`)  
  - Push (Service Worker / VAPID)  
- Interface notification center  
- Logs d’envoi et d’erreur

✅ Critères d’acceptation  
- Notifications créées à chaque événement  
- In-app & push fonctionnels  
- Utilisateur peut marquer lu/non lu  
- Emails bien reçus (loggable)

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Haute**

👥 Personas concernés  
- **Utilisateur**  
- **Admin**

🧪 Cas d’utilisation  
- Confirmation de réservation  
- Rappel de retour ou caution  
- Échec envoi email → log

🎨 UX/UI  
- Cloche + badge nombre non lus  
- Panneau slide-in pour push  
- Templates email avec logo & tenant

---

## ⚙️ 8. Configuration avancée
🎯 Objectif utilisateur  
Permettre aux admin de personnaliser règles et paramètres globaux ou par section.

🧩 Sous-tâches techniques  
- Table `Config` (clé, valeur, tenantId, sectionId)  
- Paramètres :  
  - Devise (€, crédits, points)  
  - Jours autorisés (entrée/sortie) par section  
  - Mode de débit (checkout ou return)  
  - SMTP, notifications, 2FA on/off  
  - Limites (durée max, nombre max de prods…)  
- Interface back-office avec mise à jour live

✅ Critères d’acceptation  
- Tous les paramètres modifiables via UI  
- Prise en compte immédiate sans reboot  
- Isolation par tenant/section

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Haute**

👥 Personas concernés  
- **Admin**

🧪 Cas d’utilisation  
- Passage devise de crédits à €  
- Changement des jours de location  
- Activation/désactivation de la 2FA

🎨 UX/UI  
- Sections claires et onglets  
- Toggle switches et selects intuitifs  
- Feedback immédiat

---

## 🔍 9. Logs & historique
🎯 Objectif utilisateur  
Tracer toutes les actions critiques pour audit et diagnostic.

🧩 Sous-tâches techniques  
- Table `AuditLog` (userId, action, target, date, IP, metadata JSON)  
- Enregistrement : login, CRUD, validation, erreur critique  
- Interface de recherche & filtres  
- Export CSV

✅ Critères d’acceptation  
- Logs générés pour chaque action critique  
- Consultables par date, user, type  
- Export fonctionnel

📈 Complexité & priorité  
- Complexité : **Faible à moyenne**  
- Priorité : **Moyenne**

👥 Personas concernés  
- **Admin**

🧪 Cas d’utilisation  
- Qui a validé la caution le 12/06 ?  
- Export des connexions du mois

🎨 UX/UI  
- Tableau paginé avec couleurs par type  
- Icônes d’action pour détail et export

---

## 📊 10. Statistiques & rapports
🎯 Objectif utilisateur  
Analyser l’usage via un dashboard modulaire personnalisable.

🧩 Sous-tâches techniques  
- Métriques : réservations, top produits, taux d’occupation  
- Filtres : période, section, produit  
- Widgets modulaires (add/remove)  
- Drag & drop pour réorganisation  
- Persistance de la config utilisateur (`CUSTOMIZE_STATS_DASHBOARD`)  
- Export CSV/Excel

✅ Critères d’acceptation  
- Dashboard par défaut pour tout admin  
- Utilisateurs autorisés peuvent réorganiser  
- Modules ajoutés/supprimés dynamiquement  
- Config persistée

📈 Complexité & priorité  
- Complexité : **Élevée**  
- Priorité : **Moyenne à haute**

👥 Personas concernés  
- **Admin / Utilisateur autorisé**

🧪 Cas d’utilisation  
- Déplacer widget “Taux d’occupation” en haut  
- Supprimer widget “Comparaison 2 périodes”

🎨 UX/UI  
- Interface drag & drop fluide  
- Widgets responsive avec settings internes  
- Sauvegarde auto + toast de confirmation

---

## 💾 11. Sauvegarde & base de données
🎯 Objectif utilisateur  
Garantir la pérennité des données grâce à des backups automatisés.

🧩 Sous-tâches techniques  
- Job CRON de dump MySQL (mysqldump)  
- Compression & stockage local  
- Rétention configurable (ex. 30 derniers dumps)  
- Export manuel via UI  
- Purge automatique des anciens

✅ Critères d’acceptation  
- Backups générés selon planning  
- Fichiers restaurables  
- UI pour lancer export manuel  
- Purge conforme

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Haute**

👥 Personas concernés  
- **Admin**

🧪 Cas d’utilisation  
- Restauration après incident  
- Backup manuel avant update

🎨 UX/UI  
- Liste des backups avec date, taille  
- Bouton “Télécharger” et “Supprimer”

---

## 🌐 12. Import / Export
🎯 Objectif utilisateur  
Importer et exporter massivement données produits, utilisateurs et réservations.

🧩 Sous-tâches techniques  
- Import Excel/CSV (produits, users, sections)  
- Validation des colonnes & données  
- Affichage des erreurs (ligne, champ)  
- Export CSV pour tables clés  
- Stockage temporaire & purge post-traitement

✅ Critères d’acceptation  
- Import vérifie la structure et affiche erreurs  
- Export CSV couvre toutes les données  
- Fichiers supprimés après usage

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Moyenne**

👥 Personas concernés  
- **Admin**  
- **Gestionnaire**

🧪 Cas d’utilisation  
- Import de 200 produits via Excel  
- Export des réservations mensuelles

🎨 UX/UI  
- Drag & drop pour import  
- Tableau récapitulatif des erreurs  

---

## 🧩 13. Hiérarchie & organisation
🎯 Objectif utilisateur  
Structurer le contenu via Sections et Sous-Sections uniquement.

🧩 Sous-tâches techniques  
- Tables `Section`, `SubSection`  
- Liaison produit/utilisateur à une Section  
- Jours autorisés configurables par Section  
- Ordre d’affichage personnalisé  
- Filtres avancés (section, statut, mot-clé)

✅ Critères d’acceptation  
- Sections & sous-sections CRUD fonctionnels  
- Produits rattachés affichés correctement  
- Jours de location par section appliqués

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Haute**

👥 Personas concernés  
- **Admin**  
- **Utilisateur**

🧪 Cas d’utilisation  
- Création Section “Photo” → Sous-section “Reflex”  
- Filtre par Sous-section

🎨 UX/UI  
- Arborescence claire  
- Dropdown sections + recherche  

---

## 💳 14. Gestion du chèque de caution
🎯 Objectif utilisateur  
Bloquer l’accès aux réservations et prix tant que la caution n’est pas validée.

🧩 Sous-tâches techniques  
- Champ `cautionStatus` : `pending`, `received`, `validated`, `exempted`  
- Interface admin pour valider/refuser  
- Masquage des prix et blocage réservation si non validée  
- Notification à la validation  
- Rappel automatique (cron)

✅ Critères d’acceptation  
- Prix masqués si `cautionStatus ≠ validated`  
- Blocage réservation  
- Validation possible par admin  
- Notification envoyée

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Haute**

👥 Personas concernés  
- **Utilisateur**  
- **Admin**

🧪 Cas d’utilisation  
- Validation du chèque → accès débloqué  
- Exemption manuelle par admin

🎨 UX/UI  
- Callout “Caution en attente”  
- Bouton “Valider ma caution” en admin  

---

## 🔒 15. Double authentification (2FA)
🎯 Objectif utilisateur  
Renforcer la sécurité par TOTP et passkeys.

🧩 Sous-tâches techniques  
- Activation/désactivation en profil  
- Génération secret TOTP + QR Code  
- WebAuthn pour passkeys  
- Validation initiale avant activation  
- Stockage sécurisé du secret

✅ Critères d’acceptation  
- Activation réussie avec code valide  
- Code demandé à chaque login  
- Désactivation possible en profil  
- Admin peut forcer 2FA sur rôle

📈 Complexité & priorité  
- Complexité : **Moyenne**  
- Priorité : **Moyenne**

👥 Personas concernés  
- **Utilisateur**  
- **Admin**

🧪 Cas d’utilisation  
- Activation via app ou passkey  
- Refus de connexion si code invalide

🎨 UX/UI  
- QR Code + instructions claires  
- Choix passkey ou TOTP

---

## 📲 16. Progressive Web App (PWA)
🎯 Objectif utilisateur  
Installer et utiliser le site comme une vraie app mobile.

🧩 Sous-tâches techniques  
- `manifest.json` (nom, icônes, couleurs)  
- `service-worker.js` (cache, stratégie offline)  
- Configuration Vite plugin PWA  
- Caching des pages clés (accueil, produits)  
- Installation prompt

✅ Critères d’acceptation  
- Installable depuis Chrome/Edge mobile  
- Icône & splash screen corrects  
- Navigation offline partielle

📈 Complexité & priorité  
- Complexité : **Faible à moyenne**  
- Priorité : **Moyenne**

👥 Personas concernés  
- **Utilisateur**

🧪 Cas d’utilisation  
- Ajout écran d’accueil  
- Accès en mode avion à liste produits

🎨 UX/UI  
- Icônes optimisées  
- Transition plein-écran native  

---

## 🎨 17. Thèmes personnalisables
🎯 Objectif utilisateur  
Adapter l’apparence à l’identité du CSE : logo, couleurs, slogan, devise.

🧩 Sous-tâches techniques  
- Page “Personnalisation” en admin  
- Upload logo et favicons  
- Sélecteur de couleurs principales  
- Champs : nom du site, slogan, devise  
- Application dynamique du thème  
- Support dark mode

✅ Critères d’acceptation  
- Modifications visibles instantanément  
- Thème isolé par tenant (préparé)  
- Rollback possible

📈 Complexité & priorité  
- Complexité : **Faible**  
- Priorité : **Moyenne**

👥 Personas concernés  
- **Admin**

🧪 Cas d’utilisation  
- Changement couleur primaire  
- Ajout d’un slogan temporaire

🎨 UX/UI  
- Preview en direct  
- Sliders et color pickers  
- Sauvegarde rapide  

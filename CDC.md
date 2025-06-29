# 📦 Fonctionnalités détaillées – CSE SaaS

🔐 1. Authentification & sécurité
🎯 Objectif utilisateur  
Permettre aux utilisateurs de s’authentifier de façon robuste, valider leur inscription et protéger leur compte.

⸻  
🔧 Sous-tâches techniques  
• Connexion sécurisée par cookie HTTP-only  
• Inscription publique ⇒ compte `pending`, validation manuelle par admin  
• Politique de mot de passe configurable (longueur, complexité, renouvellement)  
• Réinitialisation par email avec token à usage unique  
• Double authentification : TOTP **et** Passkey (WebAuthn)  
• Mise en sommeil automatique après X jours d’inactivité (cron)  
• Journal d’acceptation RGPD (date, version)

⸻  
✅ Critères d’acceptation  
• Inscription crée un compte `pending`  
• Connexion autorisée seulement si `status = active`  
• 2FA demandée lorsque activée ou requise par rôle  
• Réinitialisation mot de passe fonctionnelle et sécurisée  
• Comptes inactifs désactivés automatiquement  
• Consentement RGPD enregistré

⸻  
📈 Complexité & priorité  
• Complexité : Élevée  
• Priorité : Critique

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Inscription → validation → connexion  
• Connexion avec Passkey  
• Échec 2FA : message d’erreur clair

⸻  
🎨 UX/UI  
• Formulaires mobiles, feedback immédiat  
• QR-code pour TOTP, prompt Passkey natif  
• Toasts succès/erreur

---

👤 2. Gestion des utilisateurs
🎯 Objectif utilisateur  
Gérer son profil, et pour les admins, gérer tous les comptes (rôles, statuts, crédits, cautions…).

⸻  
🔧 Sous-tâches techniques  
• CRUD complet `User` (nom, email, téléphone…)  
• Statuts : `pending`, `active`, `suspended`, `disabled`  
• Gestion du solde de crédits et du statut de caution  
• Attribution dynamique de rôles & permissions  
• Historique des connexions et actions

⸻  
✅ Critères d’acceptation  
• Utilisateur modifie son profil  
• Admin crée, désactive ou supprime un compte  
• Crédits et cautions visibles et éditables  
• Historique consultable

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Mise à jour de l’adresse email perso  
• Admin recharge le crédit d’un collaborateur  
• Suspension d’un compte non conforme

⸻  
🎨 UX/UI  
• Tableau paginé avec recherche et filtres  
• Modals d’édition inline  
• Badges de statut et jauge de crédit

---

📦 3. Gestion des produits
🎯 Objectif utilisateur  
Créer et consulter des fiches produits riches (images, PDF, vidéos).

⸻  
🔧 Sous-tâches techniques  
• CRUD `Product` (nom, description, prix, durée min/max, statut)  
• Upload multi-fichiers (images, PDF, vidéos) avec preview  
• Hébergement local `/uploads/products/{id}`  
• Attributs dynamiques clé :valeur  
• Liaison Section/SubSection

⸻  
✅ Critères d’acceptation  
• Au moins une image obligatoire à la création  
• Fichiers listés et téléchargeables  
• Filtrage par statut et section opérationnel

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne → Élevée  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin / Gestionnaire  
• Utilisateur

⸻  
🧪 Cas d’utilisation  
• Publication d’un reflex avec 3 photos + notice PDF  
• Ajout tardif d’une vidéo tuto  
• Rejet d’un fichier > 100 Mo

⸻  
🎨 UX/UI  
• Zone drag-and-drop, miniatures instantanées  
• Fiche produit en onglets : Info | Fichiers | Historique  
• Étiquette statut (« Disponible », « Archivé »)

---

📅 4. Réservation & calendrier
🎯 Objectif utilisateur  
Réserver un produit via un calendrier clair, dans le respect des règles CSE.

⸻  
🔧 Sous-tâches techniques  
• Modèle `Reservation` (dates, code unique, statut)  
• Jours d’entrée/sortie configurables **par section**  
• Vérification solde / caution avant validation  
• Blocage jours fériés, durées min/max  
• Notification création & confirmation

⸻  
✅ Critères d’acceptation  
• Calendrier affiche disponibilités en temps réel  
• Message d’erreur si règle violée  
• Code unique généré automatiquement  
• Historique visible par utilisateur

⸻  
📈 Complexité & priorité  
• Complexité : Élevée  
• Priorité : Critique

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Réservation jeudi→lundi, validation auto  
• Blocage si caution non validée  
• Prolongation si créneau libre

⸻  
🎨 UX/UI  
• Couleurs dispo/indispo distinctes  
• Résumé avant validation  
• Statut en temps réel dans « Mes réservations »

---

🔁 5. Mouvements (Entrée / Sortie)
🎯 Objectif utilisateur  
Tracer la sortie et le retour des produits avec dates réelles et justificatifs.

⸻  
🔧 Sous-tâches techniques  
• Modèle `Movement` (`checkout`, `return`, état, fichiers)  
• Permissions spéciales : `BYPASS_CHECKOUT_DAY`, `BYPASS_RETURN_DAY`  
• Calcul automatique du retard  
• Historique par produit et utilisateur

⸻  
✅ Critères d’acceptation  
• Date réelle enregistrée + état produit  
• Blocage hors jours autorisés sans permission  
• Historique complet consultable

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Gestionnaire  
• Admin

⸻  
🧪 Cas d’utilisation  
• Retour tardif → retard affiché  
• Sortie exceptionnelle via permission spéciale  
• Upload photo d’un dommage

⸻  
🎨 UX/UI  
• Formulaire sortie/retour avec calendrier  
• Badge « Dérogation » si hors règle  
• Timeline des mouvements

---

🧰 6. Maintenance planifiée
🎯 Objectif utilisateur  
Planifier et documenter les maintenances produits pour maximiser la fiabilité.

⸻  
🔧 Sous-tâches techniques  
• Modèle `Maintenance` (unique ou récurrente)  
• Blocage automatique du produit pendant la période  
• Notifications utilisateurs impactés  
• Historique exportable

⸻  
✅ Critères d’acceptation  
• Blocage effectif sur la plage planifiée  
• Historique visible par admin  
• Notif envoyée avant intervention

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Gestionnaire  
• Admin

⸻  
🧪 Cas d’utilisation  
• Inspection annuelle automatique  
• Maintenance urgente manuelle  
• Conflit réservation / maintenance → alerte

⸻  
🎨 UX/UI  
• Planning global (vue calendrier)  
• Formulaire simple dates + description  
• Badge “🛠️ Maintenance” sur produit

---

🔔 7. Notifications (email, in-app, push)
🎯 Objectif utilisateur  
Être informé en temps réel des événements clés.

⸻  
🔧 Sous-tâches techniques  
• Table `Notification` (type, statut lu)  
• Canaux : SMTP, Service Worker + OneSignal, in-app  
• Déclencheurs multiples (réservation, retour tardif, caution…)  
• Centre de notifications consultable

⸻  
✅ Critères d’acceptation  
• Notification créée à chaque événement  
• Badge non lus mis à jour  
• Logs d’envoi

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Rappel de retour imminent  
• Échec email → log  
• Annonce globale affichée en bannière

⸻  
🎨 UX/UI  
• Icône cloche + compteur  
• Panneau slide-in listant les notifications  
• Templates email avec logo

---

⚙️ 8. Configuration avancée
🎯 Objectif utilisateur  
Personnaliser les règles globales ou par section.

⸻  
🔧 Sous-tâches techniques  
• Table `Config` (clé, valeur, scope tenant/section)  
• Paramètres : devise, jours autorisés, SMTP, 2FA on/off, limites…  
• Prise en compte immédiate sans redémarrage

⸻  
✅ Critères d’acceptation  
• Paramètres modifiables via UI  
• Isolation par tenant/section  
• Changements appliqués instantanément

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin

⸻  
🧪 Cas d’utilisation  
• Activer la 2FA globale  
• Passer la devise de « crédits » à « € »  
• Modifier les jours de sortie d’une section

⸻  
🎨 UX/UI  
• Onglets par catégorie  
• Toggle switches, selects  
• Feedback immédiat

---

🔍 9. Logs & historique
🎯 Objectif utilisateur  
Tracer toutes les actions critiques pour audit et diagnostic.

⸻  
🔧 Sous-tâches techniques  
• Table `AuditLog` (userId, action, target, date, IP)  
• Enregistrement login, CRUD, validations, erreurs  
• Recherche + filtres, export CSV  
• Inviolabilité (lecture seule)

⸻  
✅ Critères d’acceptation  
• Log créé pour chaque action critique  
• Export fonctionnel  
• Interface filtrable

⸻  
📈 Complexité & priorité  
• Complexité : Faible → Moyenne  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Admin

⸻  
🧪 Cas d’utilisation  
• Retrouver qui a validé une caution  
• Export des connexions mensuelles

⸻  
🎨 UX/UI  
• Tableau paginé coloré  
• Icônes par type d’action  
• Bouton export

---

📊 10. Statistiques & rapports
🎯 Objectif utilisateur  
Analyser l’usage via un dashboard personnalisable.

⸻  
🔧 Sous-tâches techniques  
• Widgets : réservations, top produits, taux d’occupation  
• Drag & drop, disposition persistée  
• Filtres période, section  
• Export CSV / Excel

⸻  
✅ Critères d’acceptation  
• Dashboard par défaut pour admin  
• Modules ajoutés/supprimés dynamiquement  
• Config sauvegardée

⸻  
📈 Complexité & priorité  
• Complexité : Élevée  
• Priorité : Moyenne → Haute

⸻  
👥 Personas concernés  
• Admin  
• Utilisateur autorisé

⸻  
🧪 Cas d’utilisation  
• Déplacer le widget “Taux d’occupation” en haut  
• Supprimer la comparaison de périodes  
• Export CSV des stats mensuelles

⸻  
🎨 UX/UI  
• Interface drag & drop fluide  
• Widgets responsives avec icône ⚙ pour réglages  
• Toast “Configuration enregistrée”

💾 11. Sauvegarde & base de données
🎯 Objectif utilisateur  
Assurer la pérennité des données via des sauvegardes planifiées et restaurables.

⸻  
🔧 Sous-tâches techniques  
• CRON `mysqldump` quotidien (gzip)  
• Stockage local `/backups/` avec rétention configurable (ex : 30 fichiers)  
• Export manuel déclenché depuis le panel admin  
• Purge automatique des anciens dumps  
• Option de téléchargement/restore dans l’UI

⸻  
✅ Critères d’acceptation  
• Backup automatique selon planning défini  
• Fichiers restaurables sans erreur  
• Export manuel disponible  
• Journalisation des opérations de backup

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin

⸻  
🧪 Cas d’utilisation  
• Avant une mise à jour majeure, l’admin lance un export manuel  
• Restauration après incident serveur  
• Purge automatique conserve les 30 derniers dumps

⸻  
🎨 UX/UI  
• Page « Sauvegardes » : liste des fichiers (date, taille)  
• Boutons `Télécharger`, `Restaurer`, `Supprimer`  
• Alerte de succès/échec en toast

---

🌐 12. Import / Export de données
🎯 Objectif utilisateur  
Importer ou exporter massivement utilisateurs, produits, réservations.

⸻  
🔧 Sous-tâches techniques  
• Import CSV/Excel avec validation colonne par colonne  
• Stockage temporaire des fichiers puis suppression  
• Mapping champs ⇄ colonnes configurable  
• Export CSV pour tables clés (Users, Products, Reservations)

⸻  
✅ Critères d’acceptation  
• Structure vérifiée avant import  
• Affichage des erreurs ligne / champ  
• Export couvre l’intégralité des données sélectionnées

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Admin  
• Gestionnaire

⸻  
🧪 Cas d’utilisation  
• Import de 200 produits depuis un fichier Excel  
• Export mensuel des réservations pour reporting

⸻  
🎨 UX/UI  
• Drag-and-drop pour import  
• Tableau récapitulatif des erreurs  
• Bouton `Exporter CSV` avec filtres (date, section)

---

🧩 13. Hiérarchie & organisation (Section / Sous-section)
🎯 Objectif utilisateur  
Structurer le catalogue via Sections et Sous-Sections uniquement.

⸻  
🔧 Sous-tâches techniques  
• Tables `Section`, `SubSection` (CRUD complet)  
• Liaison produits / utilisateurs à une section  
• Jours autorisés configurables par section  
• Ordre d’affichage personnalisable

⸻  
✅ Critères d’acceptation  
• Sections créables, éditables, supprimables  
• Produits correctement rattachés / filtrés  
• Jours de location appliqués par section

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin  
• Utilisateur

⸻  
🧪 Cas d’utilisation  
• Création section « Photo » → sous-section « Reflex »  
• Filtrer la liste par sous-section

⸻  
🎨 UX/UI  
• Arborescence collapsible  
• Dropdown section + recherche  
• Badge couleur par section

---

💳 14. Gestion du chèque de caution
🎯 Objectif utilisateur  
Bloquer l’accès aux réservations tant que la caution n’est pas validée.

⸻  
🔧 Sous-tâches techniques  
• Champ `cautionStatus` : `pending`, `received`, `validated`, `exempted`  
• Interface admin pour valider/refuser  
• Masquage des prix + blocage réservation si non validée  
• Rappel automatique (cron)

⸻  
✅ Critères d’acceptation  
• Prix masqué si caution non validée  
• Validation possible par admin  
• Notification envoyée à validation

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Validation du chèque → accès débloqué  
• Exemption manuelle par admin

⸻  
🎨 UX/UI  
• Callout « Caution en attente »  
• Bouton `Valider ma caution` dans la fiche admin

---

🔒 15. Double authentification (2FA) configurable
🎯 Objectif utilisateur  
Renforcer la sécurité via TOTP ou Passkeys, avec exigences par rôle.

⸻  
🔧 Sous-tâches techniques  
• Activation/désactivation dans le profil utilisateur  
• QR-code TOTP, ajout Passkey WebAuthn  
• Paramètre `securityLevel` par rôle (`aucune` / `2FA` / `Passkey`)  
• Méthode utilisée loggée dans l’audit

⸻  
✅ Critères d’acceptation  
• Activation 2FA réussie → code demandé à la connexion  
• Rôle peut exiger 2FA  
• Audit conserve « Connexion via Passkey/TOTP »

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Admin force 2FA pour le rôle « Gestionnaire »  
• Utilisateur active TOTP et teste le code

⸻  
🎨 UX/UI  
• Section « Sécurité » : liste méthodes, bouton `Ajouter`  
• Étapes guidées, feedback succès

---

📲 16. Progressive Web App (PWA)
🎯 Objectif utilisateur  
Installer et utiliser le site comme une application mobile native.

⸻  
🔧 Sous-tâches techniques  
• Fichier `manifest.json` (nom, icônes, couleurs)  
• `service-worker.js` : cache pages clés, offline partiel  
• Plugin Vite PWA avec stratégie de mise à jour  
• Prompt d’installation

⸻  
✅ Critères d’acceptation  
• Installable depuis Chrome/Edge/Safari mobile  
• Icône & splash screen corrects  
• Navigation offline partielle fonctionne

⸻  
📈 Complexité & priorité  
• Complexité : Faible → Moyenne  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Utilisateur  

⸻  
🧪 Cas d’utilisation  
• Ajout à l’écran d’accueil  
• Consultation de la liste produits en mode avion

⸻  
🎨 UX/UI  
• Bannière « Ajouter à l’écran d’accueil »  
• Transition plein écran native

---

🎨 17. Thèmes personnalisables
🎯 Objectif utilisateur  
Adapter l’apparence du portail à l’identité du CSE.

⸻  
🔧 Sous-tâches techniques  
• Upload logo, favicon  
• Sélecteur de couleur primaire + secondaire  
• Champs siteName, slogan, devise  
• Support dark / light, préférence par utilisateur

⸻  
✅ Critères d’acceptation  
• Modif visible instantanément  
• Thème isolé par tenant  
• Rollback possible

⸻  
📈 Complexité & priorité  
• Complexité : Faible  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Admin  
• Utilisateur (préférence sombre/clair)

⸻  
🧪 Cas d’utilisation  
• Changer couleur primaire  
• Activer dark mode automatique

⸻  
🎨 UX/UI  
• Live-preview dans le panneau « Personnalisation »  
• Sliders, color pickers, switch sombre/clair

---

🛡️ 18. Rôles & permissions personnalisées
🎯 Objectif utilisateur  
Gérer l’accès finement via rôles héritables et permissions scoppables.

⸻  
🔧 Sous-tâches techniques  
• Tables `Permission`, `Role` (héritage, scope section)  
• Association multiple User⇄Role  
• Middleware `hasPermission(user, key, scope?)`  
• Matrice d’administration visuelle  
• Création limitée à `MANAGE_ROLES`  
• Rôles par défaut : `super-admin`, `utilisateur`

⸻  
✅ Critères d’acceptation  
• Attribution multi-rôle fonctionnelle  
• Permissions locales par section  
• Héritage effectif  
• Matrice interactive

⸻  
📈 Complexité & priorité  
• Complexité : Très élevée  
• Priorité : Critique

⸻  
👥 Personas concernés  
• Admin

⸻  
🧪 Cas d’utilisation  
• Rôle « Gestionnaire Photo » limité à la section Photo  
• Super-admin hérite de tout

⸻  
🎨 UX/UI  
• Tableau rôles × permissions (checkbox)  
• Filtres par catégorie, scope

---

📑 19. Audit global inviolable
🎯 Objectif utilisateur  
Tracer toutes les actions (lecture seule) sans possibilité de falsification.

⸻  
🔧 Sous-tâches techniques  
• Table `GlobalAuditLog` hashée (SHA-256 par ligne)  
• Middleware `logAction()` sur chaque endpoint critique  
• Interface filtres : user, action, date, IP  
• Export CSV/Excel

⸻  
✅ Critères d’acceptation  
• Logs non modifiables, non supprimables  
• Recherche + export fonctionnels  
• Accessible aux rôles ayant `VIEW_GLOBAL_AUDIT_LOG`

⸻  
📈 Complexité & priorité  
• Complexité : Très élevée  
• Priorité : Critique

⸻  
👥 Personas concernés  
• Super-admin  
• Admin autorisé

⸻  
🧪 Cas d’utilisation  
• Vérifier qui a supprimé un produit  
• Suivre les connexions suspectes

⸻  
🎨 UX/UI  
• Tableau couleur par type d’action  
• Modal détail (méta-données JSON)  
• Bouton export

---

🧨 20. Journalisation des erreurs système
🎯 Objectif utilisateur  
Enregistrer les erreurs serveur (500, 403, timeout) pour diagnostic.

⸻  
🔧 Sous-tâches techniques  
• Middleware global `onError`  
• Table `ServerErrorLog` (type, message, stack, route, date)  
• Filtre & recherche dans l’UI  
• Option d’alerting futur (email, webhook)

⸻  
✅ Critères d’acceptation  
• Toute erreur critique loggée automatiquement  
• Logs consultables par date & type  
• Export CSV disponible

⸻  
📈 Complexité & priorité  
• Complexité : Faible  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Admin  
• DevOps

⸻  
🧪 Cas d’utilisation  
• Analyse des 500 récents pour corriger un bug  
• Filtrer les timeouts API externes

⸻  
🎨 UX/UI  
• Tableau erreurs avec couleur par niveau (error, warn)  
• Champ recherche plein texte  
• Bouton export CSV

🧾 21. Historique personnel & traçabilité
🎯 Objectif utilisateur  
Donner à chaque utilisateur (et aux admins depuis la fiche d’un utilisateur) un accès en lecture seule à **l’historique chronologique de ses actions** : réservations, retours, modifications de profil, connexions, 2FA, etc.

⸻  
🔧 Sous-tâches techniques  
• Agréger `AuditLog`, `Reservation`, `Movement` → endpoint `/me/history` et `/admin/user/:id/history`  
• Filtres dynamiques : période, type d’action  
• Téléchargement **CSV & PDF** générés à la demande (jsPDF / pdfmake)  
• Route sécurisée (auth + ownership)  
• Log « historique exporté » dans l’audit

⸻  
✅ Critères d’acceptation  
• L’utilisateur ne voit que ses actions  
• L’admin accède via la fiche utilisateur  
• Filtres fonctionnent sans rechargement  
• Boutons « Télécharger CSV » / « Télécharger PDF » opérationnels

⸻  
📈 Complexité & priorité  
• Complexité : Faible → Moyenne  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Aélia exporte en PDF ses 6 dernières réservations  
• L’admin vérifie l’historique d’un compte litigieux

⸻  
🎨 UX/UI  
• Page « Mon historique » : table ou timeline, icônes par action  
• Boutons `CSV` `PDF` en haut à droite  
• Header rouge si > 100 lignes (pagination)

---

🔔 22. Rappels intelligents & automatisés
🎯 Objectif utilisateur  
Recevoir des rappels personnalisés (e-mail, push, in-app) avant/pendant/après les réservations, configurables par l’utilisateur et supervisés par l’admin.

⸻  
🔧 Sous-tâches techniques  
• Table `ReminderRules` (globales) + `UserReminderPreferences` (perso)  
• Scheduler cron (15 min) pour générer les envois  
• Modèles pré-remplis (24 h avant, 2 h avant, etc.) activables en 1 clic  
• Interface admin : créer règles, **périodes de suspension**, délais (24/48/72 h)  
• Stock `ReminderSent` pour éviter doublons

⸻  
✅ Critères d’acceptation  
• Utilisateur peut ajouter plusieurs rappels par événement  
• Admin peut suspendre tous les rappels sur une plage  
• Pas de doublon pour un même rappel  
• Désactivation par l’utilisateur honorée

⸻  
📈 Complexité & priorité  
• Complexité : Élevée  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin  

⸻  
🧪 Cas d’utilisation  
• Maël active modèles « 24 h avant » et « 2 h avant »  
• Le CSE suspend les rappels du 1-15 août

⸻  
🎨 UX/UI  
• Onglet « Mes rappels » (form + liste)  
• Admin : tableau règles + calendrier de suspension  
• Badge cloche + notif classique

---

💬 23. Messagerie interne temps réel
🎯 Objectif utilisateur  
Permettre un **chat en temps réel** entre utilisateurs et admins, lié à une réservation ou en fil général.

⸻  
🔧 Sous-tâches techniques  
• WebSocket (`socket.io`) + tables `Thread`, `Message`  
• Multi-admin : `assignedAdminIds[]` dans `Thread`  
• Types de fils : « Assistance générale » ou lié (`Reservation`, `Product`)  
• Pièces jointes (img/PDF ≤ 5 Mo)  
• Clôture manuelle, audit de chaque message

⸻  
✅ Critères d’acceptation  
• Scan temps réel, notifications push/in-app  
• Attachments consultables  
• Fil marqué `closed` indisponible à l’envoi  
• Historique non éditable

⸻  
📈 Complexité & priorité  
• Complexité : Très élevée  
• Priorité : Critique

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin (multi-agents)

⸻  
🧪 Cas d’utilisation  
• Sarah ouvre « Assistance générale », deux admins répondent  
• Fichier photo d’un produit abîmé joint dans la discussion

⸻  
🎨 UX/UI  
• Icone 💬 persistant  
• Chat type “support” sur mobile et desktop  
• Liste des fils côté admin (filtrer ouverts/fermés)

---

🧪 24. Mode démo / simulation
🎯 Objectif utilisateur  
Essayer la plateforme sans impacter les vraies données : **mode libre** ou **scénario guidé** pas-à-pas.

⸻  
🔧 Sous-tâches techniques  
• Drapeau `demoMode` (tenant) ; tables volatiles ou mémoire  
• Page d’entrée : `🔓 Mode libre` / `📋 Mode guidé`  
• Scénarios créés par admin (étapes, instructions)  
• Purge auto à la déconnexion ou toutes les X h  
• Bannière `🧪 DÉMO` + couleur secondaire différente

⸻  
✅ Critères d’acceptation  
• Choix libre/guidé visible dès l’entrée  
• Aucune donnée réelle modifiée  
• Scénario guidé empêche de sauter les étapes sauf abandon  
• Admin peut créer/activer des scénarios

⸻  
📈 Complexité & priorité  
• Complexité : Élevée  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Nouvel utilisateur  
• Admin formateur

⸻  
🧪 Cas d’utilisation  
• Démo publique pendant une réunion  
• Scénario “réserver + retourner” pour formation

⸻  
🎨 UX/UI  
• Page d’accueil spéciale démo  
• Overlay étape en cours (guidé)  
• Badge Démo dans le header

---

📄 25. Génération manuelle de documents PDF
🎯 Objectif utilisateur  
Télécharger à la demande des **justificatifs PDF** : réservation, retour, caution.

⸻  
🔧 Sous-tâches techniques  
• Templates dynamiques (logo, couleur tenant)  
• Génération jsPDF / puppeteer > route sécurisée  
• Bouton `Télécharger PDF` dans les fiches adaptées  
• Entrée d’audit “PDF généré”  

⸻  
✅ Critères d’acceptation  
• Document clair, horodaté, non modifiable  
• Disponible uniquement pour l’utilisateur concerné ou l’admin  
• Pas d’envoi automatique ; action manuelle

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Maël joint le PDF à un dossier RH  
• Admin imprime un bon de retour signé

⸻  
🎨 UX/UI  
• Bouton « 📄 Justificatif PDF »  
• Modal preview (optionnel) avant téléchargement

---

📆 26. Calendrier global administrateur
🎯 Objectif utilisateur  
Vue centralisée (jour/sem/mois/année) de toutes les réservations, maintenances, fermetures, avec **export PDF**.

⸻  
🔧 Sous-tâches techniques  
• Lib : FullCalendar / React-Big-Calendar  
• Vue J/S/M/A, filtres section/statut/type  
• Export PDF via puppeteer pour chaque vue  
• Glisser-déposer pour déplacer maintenance, créer fermeture

⸻  
✅ Critères d’acceptation  
• Tous les événements affichés (couleurs)  
• Filtres fonctionnent  
• Boutons export PDF jour/sem/mois/an OK  
• Vue réservée aux rôles `VIEW_GLOBAL_CALENDAR`

⸻  
📈 Complexité & priorité  
• Complexité : Élevée  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin  
• Gestionnaire

⸻  
🧪 Cas d’utilisation  
• Export du planning semaine pour affichage physique  
• Détection pics d’occupation section Photo

⸻  
🎨 UX/UI  
• Sidebar filtres  
• Légende couleurs  
• Bouton `📄 Exporter PDF`

---

🚪 28. Mode fermeture générale du portail
🎯 Objectif utilisateur  
Fermer temporairement le site (maintenance, vacances), avec message public et **réouverture auto**.

⸻  
🔧 Sous-tâches techniques  
• Table `SiteClosure` (dates, message, autoReopen)  
• Page publique d’info + compte à rebours  
• Permission spéciale `LIMITED_ACCESS_DURING_CLOSURE`  
• Historique des fermetures (audit)  
• Alertes préventives 48 h avant (configurables)

⸻  
✅ Critères d’acceptation  
• Fermeture active bloque toutes les actions utilisateur  
• Admin garde l’accès back-office  
• Réouverture auto respectée si configurée  
• Historique listé dans l’UI

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne → Élevée  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin  
• Tous utilisateurs (lecture seule écran fermeture)

⸻  
🧪 Cas d’utilisation  
• Fermeture estivale 1-31 août avec message personnalisé  
• Technicien accède grâce à `LIMITED_ACCESS_DURING_CLOSURE`

⸻  
🎨 UX/UI  
• Page « Portail fermé » avec logo, dates, message  
• Bannière d’état dans le back-office admin  
• Form planifier/modifier fermeture

---

🎟️ 29. Vérification par QR code
🎯 Objectif utilisateur  
Scanner un QR code pour **valider remise ou retour** d’un produit sur place.

⸻  
🔧 Sous-tâches techniques  
• QR généré à la confirmation (`reservationToken`)  
• Page `/scan` admin (WebRTC + fall-back input)  
• Actions : Valider remise / Valider retour  
• Scan loggé dans l’audit

⸻  
✅ Critères d’acceptation  
• QR unique, usage unique ou expiré  
• Scan affiche fiche récapitulative  
• Permissions `SCAN_RESERVATION_QR` requise  
• Erreur claire si QR invalide

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Agent de terrain  
• Admin  
• Utilisateur (détient le QR)

⸻  
🧪 Cas d’utilisation  
• Remise rapide d’un jeu de société  
• Retour scanné et horodaté

⸻  
🎨 UX/UI  
• Bouton `📷 Scanner`  
• Carte récap : utilisateur, produit, dates  
• Toast succès/erreur

---

🛑 30. Blocage temporaire produit / section
🎯 Objectif utilisateur  
Planifier une **indisponibilité** d’un produit ou d’une section pour inventaire, événement, etc.

⸻  
🔧 Sous-tâches techniques  
• Table `UnavailabilityPeriod` (targetType, dates, reason)  
• Option admin : **masquer** ou **griser** l’élément  
• Message utilisateur configurable (motif affiché ou non)  
• Fin de période : dispo auto

⸻  
✅ Critères d’acceptation  
• Indisponibilité empêche réservation sur la plage  
• Choix masquer/griser respecté  
• Motif public optionnel  
• Modification / annulation possible par admin

⸻  
📈 Complexité & priorité  
• Complexité : Faible → Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin  
• Utilisateur

⸻  
🧪 Cas d’utilisation  
• Section Photo bloquée pour inventaire 1-5 nov.  
• Produit spécifique masqué pendant un prêt exceptionnel

⸻  
🎨 UX/UI  
• Fiche produit/section → `📅 Bloquer période`  
• Calendrier affiche barres rouge/gris  
• Toggle « Masquer des listes »  

📥 32. Fichiers liés aux produits
🎯 Objectif utilisateur  
Fournir aux utilisateurs des documents (notices, photos HD, vidéos) directement dans la fiche produit, et permettre aux admins d’en gérer le contenu.

⸻  
🔧 Sous-tâches techniques  
• Upload multi-format : PDF, JPG/PNG/WebP, MP4/WebM, DOCX, etc.  
• Chemin stockage : `/uploads/products/{productId}/`  
• Métadonnées : type, taille, date, auteur, visibilité (`public|admin`)  
• Suppression / remplacements sécurisés  
• Galerie images + lecteur vidéo intégré  
• Prévisualisation PDF (iframe) ou téléchargement

⸻  
✅ Critères d’acceptation  
• Admin ajoute/retire des fichiers sans erreur  
• Les documents publics sont listés pour l’utilisateur  
• Images s’affichent dans la galerie, vidéos lisibles  
• Action d’upload/suppression inscrite dans l’audit

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin / Gestionnaire – gèrent les fichiers  
• Utilisateur – consulte et télécharge

⸻  
🧪 Cas d’utilisation  
• Ajout d’un manuel PDF à un vidéoprojecteur  
• Vidéo tuto visible avant réservation  
• Photo d’un accessoire supplémentaire ajoutée après-coup

⸻  
🎨 UX/UI  
• Onglet « 📎 Fichiers » dans la fiche produit  
• Drag-and-drop + barre de progression  
• Icônes différenciées 📄 🖼️ 🎬

---

👤 33. Suivi des utilisateurs inactifs
🎯 Objectif utilisateur  
Identifier, relancer ou désactiver les comptes dormants pour maintenir une base saine.

⸻  
🔧 Sous-tâches techniques  
• Détection : dernier login > X j, aucune action > Y j (paramétrables)  
• Page « Inactifs » triable : nom, rôle, dernier login, dernière action  
• Actions groupées : `Relancer` (email+push) | `Désactiver`  
• Relance auto optionnelle à N j  
• Si compte désactivé auto ➜ réactivation instantanée à la prochaine connexion

⸻  
✅ Critères d’acceptation  
• Liste exacte des inactifs selon seuils  
• Relance manuelle/auto envoyée ; entrée d’audit créée  
• Désactivation bloque la connexion jusqu’à reconnexion  
• Export CSV fonctionnel

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Admin

⸻  
🧪 Cas d’utilisation  
• Relance groupée des comptes inactifs 90 j  
• Auto-désactivation après 365 j d’inactivité  
• Réactivation automatique d’un utilisateur revenu

⸻  
🎨 UX/UI  
• Badge rouge si > N inactifs  
• Boutons groupés en barre d’action  
• Filtre 30/60/90/180 j

---

🔐 34. Authentification forte (2FA + Passkeys avancé)
🎯 Objectif utilisateur  
Sécuriser les comptes via TOTP, Passkeys, et exiger un niveau minimal selon le rôle.

⸻  
🔧 Sous-tâches techniques  
• Méthodes : mot de passe, TOTP, Passkey WebAuthn  
• Table `UserSecurityMethod` (type, addedAt, lastUsed)  
• Règle `securityLevel` par rôle : `none | any2FA | passkey`  
• Journal d’audit : méthode de connexion loggée  
• Interface « Sécurité » : activer, révoquer, ajouter passkey  

⸻  
✅ Critères d’acceptation  
• Ajout TOTP : QR + code test validé  
• Ajout Passkey via prompt navigateur  
• Si rôle exige 2FA, connexion impossible sans méthode active  
• Audit affiche « Connexion via Passkey »

⸻  
📈 Complexité & priorité  
• Complexité : Élevée  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Tous utilisateurs  
• Admin (configuration des rôles)

⸻  
🧪 Cas d’utilisation  
• Super-admin force 2FA pour les gestionnaires  
• Utilisateur ajoute deux passkeys (PC + mobile)

⸻  
🎨 UX/UI  
• Liste méthodes actives  
• Bouton `Ajouter Passkey` – bouton `QR TOTP`  
• Indicateur niveau de sécurité requis

---

🛠️ 35. Mode maintenance produit
🎯 Objectif utilisateur  
Bloquer temporairement un produit pour réparation/contrôle sans le retirer du catalogue.

⸻  
🔧 Sous-tâches techniques  
• Nouveau statut `maintenance` avec dates début/fin  
• Champs : Motif (obligatoire), Note interne, Pièce jointe  
• Choix admin : afficher ou non le motif côté public  
• Fin auto (ou validation manuelle paramétrable)  
• Produits grisés/indisponibles pendant la période

⸻  
✅ Critères d’acceptation  
• Admin peut définir la période et motif  
• Produit marqué indisponible ; non réservable  
• Retour à Disponible conforme (auto ou manuel)

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Admin  
• Utilisateur (information)

⸻  
🧪 Cas d’utilisation  
• Réparation d’un casque 5-10 j  
• Motif public masqué par admin

⸻  
🎨 UX/UI  
• Bouton « 🛠️ Maintenance » dans la fiche produit  
• Badge 🛠️ + bannière « Retour prévu le … »

---

📢 36. Annonces globales
🎯 Objectif utilisateur  
Publier des messages importants visibles par tous (fermeture, nouveauté…).

⸻  
🔧 Sous-tâches techniques  
• Table `Announcement` (title, body, startAt, endAt, createdBy)  
• Bannière affichée sur tableau de bord utilisateurs  
• Icône haut de page + centre de notifications  
• Historique + désactivation manuelle

⸻  
✅ Critères d’acceptation  
• Admin crée, édite, supprime une annonce  
• Annonce visible selon dates, puis expire  
• Stockée dans l’audit « ANNOUNCEMENT_POST »

⸻  
📈 Complexité & priorité  
• Complexité : Faible  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Admin  
• Tous utilisateurs

⸻  
🧪 Cas d’utilisation  
• Message « Portail fermé vendredi » du 10 → 12 mai  
• Nouveau produit vedette annoncé

⸻  
🎨 UX/UI  
• Editeur riche (markdown)  
• Bannière colorée haut de page

---

🌙 37. Mode sombre par préférence utilisateur
🎯 Objectif utilisateur  
Offrir un thème sombre activable dans les préférences ou suivant le système.

⸻  
🔧 Sous-tâches techniques  
• Toggle `theme = light|dark|auto` enregistré en DB + localStorage  
• Classes CSS variables couleurs (tailwind --tw)  
• Détection `prefers-color-scheme` si `auto`

⸻  
✅ Critères d’acceptation  
• Switch instantané sans refresh  
• Préférence sauvegardée et restaurée à la reconnexion  
• Images/logos adaptés si nécessaire

⸻  
📈 Complexité & priorité  
• Complexité : Faible  
• Priorité : Moyenne

⸻  
👥 Personas concernés  
• Tous utilisateurs  

⸻  
🧪 Cas d’utilisation  
• Utilisateur active dark mode permanent  
• App suit le thème OS en `auto`

⸻  
🎨 UX/UI  
• Switch ☀️🌙 dans le menu profil  
• Palette couleurs méticuleusement ajustée

---

🛎️ 38. Centre de notifications
🎯 Objectif utilisateur  
Accéder à l’historique complet des notifications (lues ou non).

⸻  
🔧 Sous-tâches techniques  
• Icône cloche avec compteur non lus  
• Route `/notifications` paginée  
• Actions : marquer tout lu, supprimer (admin)  
• Stockage `Notification.readAt`  

⸻  
✅ Critères d’acceptation  
• Notification apparaissant dans le centre après envoi  
• Statut lu/non-lu modifiable  
• Badge se met à jour en temps réel

⸻  
📈 Complexité & priorité  
• Complexité : Moyenne  
• Priorité : Haute

⸻  
👥 Personas concernés  
• Utilisateur  
• Admin

⸻  
🧪 Cas d’utilisation  
• Utilisateur consulte 5 anciennes notifications  
• Admin efface une notification erronée globalement

⸻  
🎨 UX/UI  
• Drawer slide-in ou page dédiée  
• Badge coloré par type (info, warning, success)  
• Bouton « Tout marquer lu »
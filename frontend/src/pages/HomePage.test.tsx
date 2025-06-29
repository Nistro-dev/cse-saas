import { render, screen } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import HomePage from './HomePage'

describe('HomePage', () => {
  it('renders the welcome section', () => {
    render(<HomePage />)
    expect(screen.getByText('CSE SaaS')).toBeInTheDocument()
    expect(screen.getByText('Produits')).toBeInTheDocument()
    // Il y a plusieurs éléments avec "Réservations", utilisons getAllByText
    expect(screen.getAllByText('Réservations')).toHaveLength(2)
  })

  it('displays feature cards', () => {
    render(<HomePage />)
    // Le texte exact dans le HTML est "Gestion utilisateurs" (sans "des")
    expect(screen.getByText('Gestion utilisateurs')).toBeInTheDocument()
    expect(screen.getByText('Catalogue produits')).toBeInTheDocument()
  })

  it('shows main sections', () => {
    render(<HomePage />)
    // Vérifions des textes qui existent vraiment
    expect(screen.getByText('Fonctionnalités principales')).toBeInTheDocument()
    expect(screen.getByText('Statistiques')).toBeInTheDocument()
  })
})

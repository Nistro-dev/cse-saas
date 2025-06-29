import { render, screen } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import App from './App'

describe('App', () => {
  it('renders without crashing', () => {
    render(<App />)
    expect(screen.getByText('CSE SaaS')).toBeInTheDocument()
  })

  it('displays the main heading', () => {
    render(<App />)
    // Vérifier que le titre CSE SaaS est présent
    expect(screen.getByRole('heading', { name: 'CSE SaaS' })).toBeInTheDocument()
  })
})
